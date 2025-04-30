package cn.bunny.services.security.service;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.model.dto.security.TokenInfo;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.security.exception.CustomAuthenticationException;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;
import org.springframework.stereotype.Component;

import java.util.function.Supplier;


/**
 * 自定义权限判断
 * 判断用户有哪些权限
 */
@Component
@Slf4j
public class CustomAuthorizationManagerServiceImpl implements AuthorizationManager<RequestAuthorizationContext> {

    @Resource
    private TokenValidationService tokenValidationService;

    @Resource
    private PermissionCheckService permissionCheckService;

    /**
     * 检查请求的Token是否携带，并判断是否过期
     *
     * @param authentication Supplier
     * @param context        RequestAuthorizationContext
     * @return AuthorizationDecision
     */
    @Override
    public AuthorizationDecision check(Supplier<Authentication> authentication, RequestAuthorizationContext context) {
        // 用户的token和用户id、请求Url
        HttpServletRequest request = context.getRequest();

        // 验证token
        TokenInfo tokenInfo = tokenValidationService.validateToken(request);

        // 验证用户状态
        validateUserStatus(tokenInfo.getLoginVo());

        // 设置用户信息
        BaseContext.setUsername(tokenInfo.getUsername());
        BaseContext.setUserId(tokenInfo.getUserId());
        BaseContext.setLoginVo(tokenInfo.getLoginVo());

        // 校验权限
        Boolean hasPermission = permissionCheckService.hasPermission(request);
        return new AuthorizationDecision(hasPermission);
    }

    private void validateUserStatus(LoginVo loginVo) {
        // 登录信息为空
        if (loginVo == null) {
            throw new CustomAuthenticationException(ResultCodeEnum.LOGIN_AUTH);
        }

        // 判断用户是否禁用
        if (loginVo.getStatus()) {
            throw new CustomAuthenticationException(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED);
        }
    }
}
