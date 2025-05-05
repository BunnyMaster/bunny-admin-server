package cn.bunny.services.security.service;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.model.dto.security.TokenInfo;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
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

    /**
     * 授权决策主方法
     * <ul>
     *  <li>Token验证失败</li>
     *  <li>用户状态异常</li>
     *  <li>权限检查失败</li>
     * </ul>
     *
     * @param authentication 认证信息提供者
     * @param context        请求授权上下文
     * @return 授权决策结果（允许/拒绝）
     * @throws CustomAuthenticationException 当出现以下情况时抛出：
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

    /**
     * 验证用户状态
     *
     * @param loginVo 用户登录信息
     * @throws CustomAuthenticationException 当用户状态异常时抛出
     */
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

