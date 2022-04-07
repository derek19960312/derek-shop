package com.derek.springcloud.gateway.service;

import reactor.core.publisher.Mono;

public interface AuthService {
	public Mono<Boolean> verifyToken (String channel, String token);
}
