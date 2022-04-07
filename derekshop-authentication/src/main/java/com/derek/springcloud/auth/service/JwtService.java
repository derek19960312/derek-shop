package com.derek.springcloud.auth.service;

import java.time.Instant;
import java.util.Date;
import java.util.UUID;

import com.derek.springcloud.shop.code.ResultCode;
import com.derek.springcloud.shop.exception.DerekShopAuthException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;

@Service
@Slf4j
public class JwtService {

	@Value("${pex.auth.token.iss}")
	private String iss;
	@Value("${pex.auth.token.expiretime}")
	private long expiration_time;
	// JWT SECRET KEY
	@Value("${pex.auth.token.jwts}")
	private String secret;

	// MAKE NEW JWT TOKEN
	public String createJwt(String channel) {
		return Jwts.builder().setIssuer(iss).setIssuedAt(new Date()).setId(UUID.randomUUID().toString())
				.claim("channel", channel).setExpiration(new Date(Instant.now().toEpochMilli() + expiration_time))
				.signWith(SignatureAlgorithm.HS512, secret).compact();
	}

	// VALIDATE JWT TOKEN
	public void validateToken(String token, String channel) throws DerekShopAuthException {
		try {
			Jwts.parser().setSigningKey(secret).parseClaimsJws(token);
		} catch (SignatureException | UnsupportedJwtException | IllegalArgumentException e) {
			if (e instanceof SignatureException) {
				log.error("Invalid JWT signature.");
			} else if (e instanceof UnsupportedJwtException) {
				log.error("Unsupported JWT token.");
			} else {
				log.error("JWT token compact of handler are invalid.");
			}
			throw new DerekShopAuthException(ResultCode.TOKEN_ACCESS_FORBIDDEN);
		} catch (MalformedJwtException | ExpiredJwtException e) {
			if(e instanceof MalformedJwtException)
				log.error("Invalid JWT token.");
			else
				log.error("Expired JWT token.");
			throw new DerekShopAuthException(ResultCode.TOKEN_INVALID_OR_EXPIRED);
		}
	}
}
