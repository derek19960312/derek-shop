package com.derek.springcloud.shop.exception;

import com.derek.springcloud.shop.code.ResultCode;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DerekShopException extends RuntimeException {
    private ResultCode code;

    public DerekShopException (ResultCode code) {
        super(code.getMsg());
        this.code = code;
    }
}
