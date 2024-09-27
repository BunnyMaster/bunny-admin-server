package cn.bunny.services.security.handelr;

import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import com.alibaba.fastjson2.JSON;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import org.springframework.security.access.AccessDeniedException;

/**
 * 没有权限访问
 */
public class SecurityAccessDeniedHandler implements org.springframework.security.web.access.AccessDeniedHandler {
    @SneakyThrows
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) {
        Result<Object> result = Result.error(ResultCodeEnum.FAIL_NO_ACCESS_DENIED);

        Object json = JSON.toJSON(result);

        // 返回响应
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().println(json);
    }
}
