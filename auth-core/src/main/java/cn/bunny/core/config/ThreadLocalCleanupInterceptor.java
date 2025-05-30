package cn.bunny.core.config;

import cn.bunny.core.context.BaseContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class ThreadLocalCleanupInterceptor implements HandlerInterceptor {

    /* 请求完成后清理 */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        BaseContext.removeUser();
    }
}