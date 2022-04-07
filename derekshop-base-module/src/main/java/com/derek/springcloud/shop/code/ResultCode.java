package com.derek.springcloud.shop.code;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public enum ResultCode {
    SUCCESS("DS0000", "成功!!!!"),
    SYSTEM_EXECUTION_ERROR("DS9999", "系統錯誤"),
    SYSTEM_EXECUTION_TIMEOUT("DS9998", "系統超時"),
    BAD_REQUEST("DS9997", "請求內容有誤!!!"),
    NOT_FOUND("DS9996", "找不到資料"),
    COMMODITY_ERROR("DC9999", "商品系統錯誤"),
    AUTH_ERROR("DA9999", "token驗證系統錯誤"),
    TOKEN_INVALID_OR_EXPIRED("DA9996", "token無效或已過期"),
    TOKEN_ACCESS_FORBIDDEN("DA9998", "token已被禁止訪問"),
    TOKEN_PWD_ERROR("DA9995", "token驗證系統,密碼錯誤"),
    TOKEN_NOT_FOUND("DA9997", "token欄位遺失");


    private String code;
    private String msg;

    public static ResultCode getValue(String code){
        for (ResultCode value : values()) {
            if (value.getCode().equals(code)) {
                return value;
            }
        }
        return SYSTEM_EXECUTION_ERROR; // 預設系统错误
    }

}
