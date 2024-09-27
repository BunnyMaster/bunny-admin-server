package cn.bunny.services.security.service.iml;

import cn.bunny.common.service.utils.JwtHelper;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.function.Supplier;


/**
 * 自定义权限判断
 * 判断用户有哪些权限
 */
@Component
@Slf4j
public class CustomAuthorizationManagerServiceImpl implements AuthorizationManager<RequestAuthorizationContext> {
    @Override
    public AuthorizationDecision check(Supplier<Authentication> authentication, RequestAuthorizationContext context) {
        // 用户的token和用户id、请求Url
        HttpServletRequest request = context.getRequest();
        String token = request.getHeader("token");
        Long userId = JwtHelper.getUserId(token);// 用户id
        String requestURI = request.getRequestURI();// 请求地址
        String method = request.getMethod();// 请求方式
        List<String> roleCodeList = authentication.get().getAuthorities().stream().map(GrantedAuthority::getAuthority).toList();// 角色代码列表

        return new AuthorizationDecision(hasRoleList(requestURI, method, userId));
    }

    /**
     * 查询用户所属的角色信息
     *
     * @param requestURI 请求url地址
     * @param method     请求方式
     * @param userId     用户id
     */
    private Boolean hasRoleList(String requestURI, String method, Long userId) {
        return true;
    }
}
