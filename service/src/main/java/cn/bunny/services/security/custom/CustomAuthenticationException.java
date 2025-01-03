package cn.bunny.services.security.custom;

import cn.bunny.dao.pojo.result.ResultCodeEnum;
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
    ResultCodeEnum resultCodeEnum;

    public CustomAuthenticationException(ResultCodeEnum codeEnum) {
        super(codeEnum.getMessage());
        this.resultCodeEnum = codeEnum;
    }
}
