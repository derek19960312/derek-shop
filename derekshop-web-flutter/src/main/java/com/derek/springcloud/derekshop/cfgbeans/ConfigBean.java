package com.derek.springcloud.derekshop.cfgbeans;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class ConfigBean {// @Configuration + ConfigBean 等於applicationContext.xml文件

	@Bean
	public RestTemplate getRestTemplate() {
		return new RestTemplate();
	}

}