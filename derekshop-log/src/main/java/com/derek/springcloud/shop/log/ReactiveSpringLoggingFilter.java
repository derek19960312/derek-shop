package com.derek.springcloud.shop.log;

import com.derek.springcloud.shop.code.ResultCode;
import com.derek.springcloud.shop.exception.DerekShopAuthException;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.core.io.buffer.DataBufferUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.codec.HttpMessageReader;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpRequestDecorator;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.HandlerStrategies;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.List;


@Slf4j
@Component
public class ReactiveSpringLoggingFilter implements WebFilter {

    /**
     * default HttpMessageReader
     */
    private static final List<HttpMessageReader<?>> messageReaders =
            HandlerStrategies.withDefaults().messageReaders();

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {

        /**
         * save request path and serviceId into gateway context
         */
        ServerHttpRequest request = exchange.getRequest();
        String path = request.getPath().pathWithinApplication().value();
        LogContext logContext = new LogContext();
        logContext.setPath(path);

        /**
         * save gateway context into exchange
         */
        exchange.getAttributes().put(LogContext.CACHE_LOG_CONTEXT,
                logContext);
        HttpHeaders headers = request.getHeaders();
        MediaType contentType = headers.getContentType();
        Long contentLength = headers.getContentLength();

        final long startTime = System.currentTimeMillis();

        if (request.getMethod() == HttpMethod.GET) {
            ReactiveLoggingHelper.logRequest(request);
            return chain.filter(exchange).doOnSuccess(aVoid -> ReactiveLoggingHelper.logResponse(exchange.getResponse(), startTime))
                    .doOnError(throwable ->  ReactiveLoggingHelper.logResponse(throwable, startTime));
        }
        if (request.getMethod() == HttpMethod.POST) {
            Flux<DataBuffer> b = request.getBody();

            if (contentLength > 0 && MediaType.APPLICATION_JSON.equals(contentType)
                    || MediaType.APPLICATION_JSON_UTF8.equals(contentType)) {
                return readBody(exchange, chain, logContext, startTime);
            }
        }
        log.error("不支援 Method:{} or Content-Type:{} or Content-Length:{}", request.getMethod(), contentType, contentLength);
        throw new DerekShopAuthException(ResultCode.BAD_REQUEST);
    }

    /**
     * ReadJsonBody
     *
     * @param exchange
     * @param chain
     * @return
     */
    private Mono<Void> readBody(
            ServerWebExchange exchange,
            WebFilterChain chain,
            LogContext logContext, long startTime) {
        /**
         * join the body
         */
        return DataBufferUtils.join(exchange.getRequest().getBody())
                .flatMap(dataBuffer -> {
                    /*
                     * read the body Flux<DataBuffer>, and release the buffer
                     * //TODO when SpringCloudGateway Version Release To G.SR2,this can be update with the new version's feature
                     * see PR https://github.com/spring-cloud/spring-cloud-gateway/pull/1095
                     */
                    byte[] bytes = new byte[dataBuffer.readableByteCount()];
                    dataBuffer.read(bytes);
                    DataBufferUtils.release(dataBuffer);
                    Flux<DataBuffer> cachedFlux = Flux.defer(() -> {
                        DataBuffer buffer =
                                exchange.getResponse().bufferFactory().wrap(bytes);
                        DataBufferUtils.retain(buffer);
                        return Mono.just(buffer);
                    });
                    /**
                     * repackage ServerHttpRequest
                     */
                    ServerHttpRequest mutatedRequest =
                            new ServerHttpRequestDecorator(exchange.getRequest()) {
                                @Override
                                public Flux<DataBuffer> getBody() {
                                    return cachedFlux;
                                }
                            };
                    /**
                     * mutate exchage with new ServerHttpRequest
                     */
                    ServerWebExchange mutatedExchange =
                            exchange.mutate().request(mutatedRequest)
                                    .response(new ResponseLoggingInterceptor(exchange.getResponse(), startTime)).build();
                    /**
                     * read body string with default messageReaders
                     */
                    return ServerRequest.create(mutatedExchange, messageReaders)
                            .bodyToMono(String.class)
                            .doOnNext(objectValue -> {
                                logContext.setCacheBody(objectValue);
                                ReactiveLoggingHelper.logRequest(mutatedRequest, objectValue);
                            }).then(chain.filter(mutatedExchange)
                                    .doOnError(throwable ->  ReactiveLoggingHelper.logResponse(throwable, startTime)));
                });
    }
}
