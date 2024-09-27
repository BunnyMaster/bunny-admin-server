package cn.bunny.services.security.handelr;

import cn.bunny.common.service.utils.ResponseUtil;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import java.io.IOException;

/**
 * 请求未认证接口
 */
@Slf4j
public class SecurityAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException {
        String token = response.getHeader("token");
        String message = authException.getMessage();
        // 创建结果对象
        Result<Object> result;

        if (token == null) {
            result = Result.error(ResultCodeEnum.LOGIN_AUTH);
            log.info("请求未登录接口：{}，用户id：{}", message, null);
        } else {
            result = Result.error(ResultCodeEnum.LOGGED_IN_FROM_ANOTHER_DEVICE);
            log.info("请求未授权接口：{}，用户id：{}", message, token);
        }

        // 返回响应
        ResponseUtil.out(response, result);
    }
}
