package com.derek.springcloud.shop.config;

import com.derek.springcloud.shop.log.ReactiveSpringLoggingFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class LogAutoConfig {
    // Api Log Filter
    @Bean
    public ReactiveSpringLoggingFilter reactiveSpringLoggingFilter() {
        return new ReactiveSpringLoggingFilter();
    }
}
