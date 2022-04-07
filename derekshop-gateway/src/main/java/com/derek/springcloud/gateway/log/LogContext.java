package com.derek.springcloud.gateway.log;

import lombok.Data;
import org.springframework.util.MultiValueMap;

@Data
public class LogContext {
    public static final String CACHE_LOG_CONTEXT = "cacheLogContext";

    /**
     * cache json body
     */
    private String cacheBody;
    /**
     * cache formdata
     */
    private MultiValueMap<String, String> formData;
    /**
     * cache reqeust path
     */
    private String path;
}
