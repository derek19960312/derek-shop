package com.derek.springcloud.gateway.serviceImpl;


import com.derek.springcloud.gateway.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import reactor.core.publisher.Mono;

import java.net.URI;

@Service
public class AuthServiceImpl implements AuthService {

	@Value("${auth.root}")
	private String authRoot;

	@Value("${auth.checkTokenEndPoint}")
	private String checkTokenEndPoint;

	@Autowired
	private WebClient.Builder webClientB;

	/*
	 * 將channel與token送到authServer做驗證
	 * @param scope
	 * @param token
	 */
	@Override
	public Mono<Boolean> verifyToken(String channel, String token) {
		//URI uri = loadBalancerClient.choose(authRoot).getUri();
		//loadBalancerClient.reconstructURI(uri)
		return webClientB
				.baseUrl(authRoot)
				.defaultHeader("channel", channel)
				.build()
					.get()
					.uri((uriBuilder -> uriBuilder
						.path(checkTokenEndPoint)
						.queryParam("token", token)
						.build()))
					.retrieve()
					.bodyToMono(Boolean.class);
	}
}
