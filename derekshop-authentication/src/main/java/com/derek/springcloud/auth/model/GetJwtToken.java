package com.derek.springcloud.auth.model;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Setter
@Getter
public class GetJwtToken {
    // 取得token用密碼
    @NotNull
    private String p;
}
