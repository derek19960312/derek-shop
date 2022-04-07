package com.derek.springcloud.auth.service;

import com.derek.springcloud.shop.code.ResultCode;
import com.derek.springcloud.shop.exception.DerekShopAuthException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TokenService {

	@Autowired
	private JwtService jwtService;

	@Value("${pex.auth.pd}")
	private String pd;
	
	public String getToken(String inpd, String channel) {

		if(StringUtils.equals(inpd, pd)) {
			return jwtService.createJwt(channel);
		}
		throw new DerekShopAuthException(ResultCode.TOKEN_PWD_ERROR);
	}
	
	public Boolean verifyJwtToken(String token, String channel) {
		try {
			jwtService.validateToken(token, channel);
			return true;
		} catch (DerekShopAuthException pe) {
			log.error(pe.getMessage(), pe);
			return false;
		}
	}
}
