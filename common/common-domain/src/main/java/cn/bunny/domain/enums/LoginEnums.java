package cn.bunny.domain.enums;


import lombok.Getter;

@Getter
public enum LoginEnums {
    // 邮箱登录请求
    EMAIL_STRATEGY("email"),
    // 默认登录请求
    default_STRATEGY("default"),
    ;

    private final String value;

    LoginEnums(String value) {
        this.value = value;
    }
}
