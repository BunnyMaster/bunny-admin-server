package cn.bunny.dao.enums;


import lombok.Getter;

@Getter
public enum LoginEnums {
    // 邮箱登录请求
    EMAIL_STRATEGY("email"),
    // 默认登录请求
    default_STRATEGY("default"),
    // 登良路请求API
    LOGIN_REQUEST_API("/api/login"),
    ;

    private final String value;

    LoginEnums(String value) {
        this.value = value;
    }
}
