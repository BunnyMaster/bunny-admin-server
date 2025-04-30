package cn.bunny.services.security.custom;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.vo.LoginVo;
import cn.bunny.services.domain.common.vo.result.ResultCodeEnum;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.domain.system.system.entity.Role;
import cn.bunny.services.mapper.system.PermissionMapper;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.security.config.WebSecurityConfig;
import cn.bunny.services.utils.JwtHelper;
import cn.bunny.services.utils.system.RoleUtil;
import com.alibaba.fastjson2.JSON;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Objects;
import java.util.function.Supplier;


/**
 * 自定义权限判断
 * 判断用户有哪些权限
 */
@Component
@Slf4j
public class CustomAuthorizationManagerServiceImpl implements AuthorizationManager<RequestAuthorizationContext> {

    @Resource
    private PermissionMapper permissionMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

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

        // 判断是否有 token
        String token = request.getHeader("token");
        if (token == null) {
            throw new CustomAuthenticationException(ResultCodeEnum.LOGIN_AUTH);
        }

        // 判断 token 是否过期
        if (JwtHelper.isExpired(token)) {
            throw new CustomAuthenticationException(ResultCodeEnum.AUTHENTICATION_EXPIRED);
        }

        // 解析JWT中的用户名
        String username = JwtHelper.getUsername(token);
        Long userId = JwtHelper.getUserId(token);

        // 查找 Redis
        Object loginVoObject = redisTemplate.opsForValue().get(RedisUserConstant.getAdminLoginInfoPrefix(username));
        LoginVo loginVo = JSON.parseObject(JSON.toJSONString(loginVoObject), LoginVo.class);

        // 登录信息为空
        if (loginVo == null) {
            throw new CustomAuthenticationException(ResultCodeEnum.LOGIN_AUTH);
        }

        // 判断用户是否禁用
        if (loginVo.getStatus()) {
            throw new CustomAuthenticationException(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED);
        }

        // 设置用户信息
        BaseContext.setUsername(username);
        BaseContext.setUserId(userId);
        BaseContext.setLoginVo(loginVo);

        // 校验权限
        return new AuthorizationDecision(hasAuth(request));
    }

    /**
     * 查询用户所属的角色信息
     *
     * @param request 请求url地址
     */
    private Boolean hasAuth(HttpServletRequest request) {
        String requestMethod = request.getMethod();

        // 根据用户ID查询角色数据
        Long userId = BaseContext.getUserId();
        List<Role> roleList = roleMapper.selectListByUserId(userId);

        // 角色代码
        List<String> roleCodeList = roleList.stream().map(Role::getRoleCode).toList();

        // 判断是否是管理员用户
        boolean checkedAdmin = RoleUtil.checkAdmin(roleCodeList);
        if (checkedAdmin) return true;

        // 判断请求地址是否是登录之后才需要访问的，已经登录了不需要验证的
        String requestURI = request.getRequestURI();
        for (String userAuth : WebSecurityConfig.userAuths) {
            if (requestURI.contains(userAuth)) return true;
        }

        // 根据角色列表查询权限信息
        List<Permission> permissionList = permissionMapper.selectListByUserId(userId);

        // 判断是否与请求路径匹配
        return permissionList.stream()
                // 过滤并转成小写进行比较
                .filter(permission -> {
                    String permissionRequestMethod = permission.getRequestMethod();
                    if (StringUtils.hasText(permissionRequestMethod)) {
                        String lowerCase = permissionRequestMethod.toLowerCase();
                        String requestMethodLowerCase = requestMethod.toLowerCase();
                        return lowerCase.equals(requestMethodLowerCase)
                                || requestURI.contains("/**");
                    }
                    return false;
                })
                .map(Permission::getRequestUrl)
                .filter(Objects::nonNull)
                .anyMatch(requestUrl -> {
                    if ((requestUrl.contains("/*") || requestUrl.contains("/**"))) {
                        return new AntPathRequestMatcher(requestUrl).matches(request);
                    } else {
                        return requestURI.matches(requestUrl);
                    }
                });
    }
}
