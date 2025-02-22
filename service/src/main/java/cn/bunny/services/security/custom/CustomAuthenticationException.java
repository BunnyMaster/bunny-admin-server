package cn.bunny.services.security.custom;

import cn.bunny.dao.vo.result.ResultCodeEnum;
import lombok.Getter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;

/**
 * 处理与认证相关的异常
 */
@Getter
@ToString
@Slf4j
public class CustomAuthenticationException extends AuthenticationException {
    String message;
    ResultCodeEnum resultCodeEnum;

    public CustomAuthenticationException(String message) {
        super(message);
        this.message = message;
    }

    public CustomAuthenticationException(ResultCodeEnum resultCodeEnum) {
        super(resultCodeEnum.getMessage());
        this.resultCodeEnum = resultCodeEnum;
    }
}
