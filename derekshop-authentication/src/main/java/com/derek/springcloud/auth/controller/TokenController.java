package com.derek.springcloud.auth.controller;

import com.derek.springcloud.auth.model.VerifyJwtToken;
import com.derek.springcloud.auth.service.TokenService;
import com.derek.springcloud.shop.dto.JwtToken;
import com.derek.springcloud.shop.exception.DerekShopAuthException;
import com.derek.springcloud.auth.model.GetJwtToken;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import io.swagger.annotations.ApiOperation;
import reactor.core.publisher.Mono;

@RestController
@Slf4j
public class TokenController {

	@Autowired
	private TokenService tokenService;

	@ApiOperation(value = "取得JwtToken", notes = "取得JwtToken")
	@PostMapping("/getJwtToken")
	public Mono<JwtToken> getJwtToken(@RequestBody @Validated GetJwtToken req, @RequestHeader("channel") String channel) {
		String token = tokenService.getToken(req.getP(), channel);
		if (StringUtils.isNotBlank(token)) {
			return Mono.just(new JwtToken(token));
		} else {
			return Mono.error(new DerekShopAuthException());
		}
	}

	@ApiOperation(value = "驗證JwtToken", notes = "驗證JwtToken")
	@GetMapping("/verifyJwtToken")
	@ResponseBody
	public Mono<Boolean> verifyJwtToken(@RequestParam("token") String token, @RequestHeader("channel") String channel) {
		return Mono.just(tokenService.verifyJwtToken(token, channel));
	}
	
}
