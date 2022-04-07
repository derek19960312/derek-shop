package com.derek.springcloud.auth.model;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;

@Getter
@Setter
public class VerifyJwtToken {
    @NotNull
    private String token;
}
