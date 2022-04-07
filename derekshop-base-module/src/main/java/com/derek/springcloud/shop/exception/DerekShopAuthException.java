package com.derek.springcloud.shop.exception;

import com.derek.springcloud.shop.code.ResultCode;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@Getter
@Setter
@ResponseStatus(HttpStatus.UNAUTHORIZED)
public class DerekShopAuthException extends DerekShopException {

    public DerekShopAuthException() {
        super(ResultCode.AUTH_ERROR);
    }
    public DerekShopAuthException(ResultCode code) {
        super(code);
    }
}
