package cn.bunny.services.security.service;

import cn.bunny.core.context.BaseContext;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.dto.security.TokenInfo;
import cn.bunny.domain.common.model.vo.LoginVo;
import cn.bunny.services.security.exception.CustomAuthenticationException;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;
import org.springframework.stereotype.Service;

import java.util.function.Supplier;


/**
 * 自定义授权管理器服务实现
 *
 * <p>负责处理API请求的授权决策，主要功能：</p>
 * <ol>
 *   <li>验证请求Token的有效性</li>
 *   <li>检查用户状态（是否禁用）</li>
 *   <li>设置当前请求上下文信息</li>
 *   <li>执行权限检查</li>
 * </ol>
 */
@Service
public class CustomAuthorizationManagerServiceImpl implements AuthorizationManager<RequestAuthorizationContext> {

    @Resource
    private TokenValidationService tokenValidationService;

    @Resource
    private PermissionCheckService permissionCheckService;

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

