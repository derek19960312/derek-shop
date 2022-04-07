package com.derek.springcloud.shop.exception;

import com.derek.springcloud.shop.code.ResultCode;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@Getter
@Setter
@ResponseStatus(HttpStatus.NOT_FOUND)
public class DerekShopCommodityException extends DerekShopException {

    public DerekShopCommodityException() {
        super(ResultCode.COMMODITY_ERROR);
    }
    public DerekShopCommodityException(ResultCode code) {
        super(code);
    }
}
