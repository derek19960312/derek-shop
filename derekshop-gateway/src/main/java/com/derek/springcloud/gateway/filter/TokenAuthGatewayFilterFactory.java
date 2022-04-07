package com.derek.springcloud.gateway.filter;

import com.derek.springcloud.gateway.service.AuthService;
import com.derek.springcloud.shop.code.ResultCode;
import com.derek.springcloud.shop.exception.DerekShopAuthException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class TokenAuthGatewayFilterFactory extends AbstractGatewayFilterFactory<TokenAuthGatewayFilterFactory.Config> {

	private static final String tokenPrefix = "Bearer ";

	@Autowired
	private AuthService authService;

	public TokenAuthGatewayFilterFactory() {
		super(Config.class);
	}

	@Override
	public GatewayFilter apply(Config config) {
		return (exchange, chain) -> {

			ServerHttpRequest request = exchange.getRequest();

			String authHeader = request.getHeaders().getFirst(HttpHeaders.AUTHORIZATION);

			// 檢查是否有帶Token，沒有則直接錯誤
			if (authHeader != null && authHeader.startsWith(tokenPrefix)) {
				String token = authHeader.substring(tokenPrefix.length());

				//開始用正Token
				Mono<Boolean> result = authService.verifyToken(config.getChannel(), token);

				return result.flatMap(r -> {
					if (!r) {
						throw new DerekShopAuthException(ResultCode.TOKEN_INVALID_OR_EXPIRED);
					} else {
						return chain.filter(exchange);
					}
				});
			} else {
				throw new DerekShopAuthException(ResultCode.TOKEN_NOT_FOUND);
			}
		};
	}

	@Getter @Setter
	public static class Config {
		private String channel;
	}
}
