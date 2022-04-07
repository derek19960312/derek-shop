package com.derek.springcloud.gateway.log;

import com.derek.springcloud.shop.code.ResultCode;
import com.derek.springcloud.shop.exception.DerekShopException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;


@Slf4j
public class ReactiveLoggingHelper {

    public static void logRequest(ServerHttpRequest httpRequest) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n");
        sb.append("---- Request Start -----------").append("\n");
        sb.append("uri       :").append(httpRequest.getPath()).append("\n");
        sb.append("method    :").append(httpRequest.getMethod()).append("\n");
        sb.append("headers   :").append(httpRequest.getHeaders()).append("\n");
        sb.append("---- Request End -------------").append("\n");
        log.info(sb.toString());
    }
    public static void logRequest(ServerHttpRequest httpRequest, String body) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n");
        sb.append("---- Request Start -----------").append("\n");
        sb.append("uri       :").append(httpRequest.getPath()).append("\n");
        sb.append("method    :").append(httpRequest.getMethod()).append("\n");
        sb.append("headers   :").append(httpRequest.getHeaders()).append("\n");
        sb.append("body      :").append(body).append("\n");
        sb.append("---- Request End -------------").append("\n");
        log.info(sb.toString());
    }
    public static void logResponse(ServerHttpResponse httpResponse, String body, long startTime) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n");
        sb.append("Response Start-------------").append("\n");
        sb.append(System.currentTimeMillis()-startTime).append(" ms\n");
        sb.append("code     :").append(httpResponse.getRawStatusCode()).append("\n");
        sb.append("msg      :").append(httpResponse.getStatusCode().getReasonPhrase()).append("\n");
        sb.append("headers  :").append(httpResponse.getHeaders()).append("\n");
        sb.append("body     :").append(body).append("\n");
        sb.append("Response End-------------").append("\n");
        log.info(sb.toString());
    }
    public static void logResponse(ServerHttpResponse httpResponse, long startTime) {
        StringBuilder sb = new StringBuilder();
        sb.append("\n");
        sb.append("---- Response Start -----------").append("\n");
        sb.append(System.currentTimeMillis()-startTime).append(" ms\n");
        sb.append("code     :").append(httpResponse.getRawStatusCode()).append("\n");
        sb.append("msg      :").append(httpResponse.getStatusCode().getReasonPhrase()).append("\n");
        sb.append("---- Response End -------------").append("\n");
        log.info(sb.toString());
    }

    public static void logResponse(Throwable throwable, long startTime) {

        ResultCode code = ResultCode.SYSTEM_EXECUTION_ERROR;
        if(throwable instanceof DerekShopException) {
            code = ((DerekShopException) throwable).getCode();
        }

        StringBuilder sb = new StringBuilder();
        sb.append("\n");
        sb.append("---- Response Start -----------").append("\n");
        sb.append(System.currentTimeMillis()-startTime).append(" ms\n");
        sb.append("code     :").append(code.getCode()).append("\n");
        sb.append("msg      :").append(throwable.getMessage()).append("\n");
        sb.append("---- Response End -------------").append("\n");
        log.info(sb.toString());
    }
}
