package cn.bunny.services.security.handelr;

import cn.bunny.domain.common.model.vo.result.Result;
import com.alibaba.fastjson2.JSON;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import java.io.IOException;

public class SecurityAuthenticationFailureHandler implements AuthenticationFailureHandler {
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException {
        // 错误消息
        String localizedMessage = exception.getLocalizedMessage();
        Result<String> result = Result.error(localizedMessage);

        // 转成JSON
        Object json = JSON.toJSON(result);

        // 返回响应
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().println(json);
    }
}
