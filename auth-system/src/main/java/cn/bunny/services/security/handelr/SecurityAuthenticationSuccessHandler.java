package cn.bunny.services.security.handelr;

import cn.bunny.domain.common.model.vo.result.Result;
import com.alibaba.fastjson2.JSON;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.io.IOException;

/**
 * 登录成功
 */
public class SecurityAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {
        // 获取用户身份信息
        Object principal = authentication.getPrincipal();
        Result<Object> result = Result.success(principal);

        // 返回
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().println(JSON.toJSON(result));
    }
}
