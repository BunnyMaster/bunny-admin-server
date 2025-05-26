package cn.bunny.services.security.service;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.core.cache.UserAuthorizationCacheService;
import cn.bunny.services.core.utils.RoleHelper;
import cn.bunny.services.domain.system.entity.Permission;
import cn.bunny.services.domain.system.entity.Role;
import cn.bunny.services.security.config.WebSecurityConfig;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Objects;

/**
 * 权限校验认证
 */
@Component
public class PermissionCheckService {

    @Resource
    private UserAuthorizationCacheService authorizationCacheService;

    /**
     * 查询用户所属的角色信息
     *
     * @param request 请求url地址
     */
    public Boolean hasPermission(HttpServletRequest request) {
        String requestMethod = request.getMethod();

        // 根据用户ID查询角色数据
        Long userId = BaseContext.getUserId();
        String username = BaseContext.getUsername();
        // List<Role> roleList = roleMapper.selectListByUserId(userId);
        List<Role> roleList = authorizationCacheService.getRolesByUser(userId, username);

        // 角色代码
        List<String> roleCodeList = roleList.stream().map(Role::getRoleCode).toList();

        // 判断是否是管理员用户
        boolean checkedAdmin = RoleHelper.checkAdmin(roleCodeList);
        if (checkedAdmin) return true;

        // 判断请求地址是否是登录之后才需要访问的，已经登录了不需要验证的
        String requestURI = request.getRequestURI();
        for (String userAuth : WebSecurityConfig.userAuths) {
            if (requestURI.contains(userAuth)) return true;
        }

        // 根据角色列表查询权限信息
        List<Permission> permissionList = authorizationCacheService.getPermissionsByUser(userId, username);

        // 判断是否与请求路径匹配
        return permissionList.stream()
                // 过滤并转成小写进行比较
                .filter(permission -> {
                    String method = permission.getRequestMethod();
                    if (StringUtils.hasText(method)) {
                        return method.equalsIgnoreCase(requestMethod) || requestURI.contains("*");
                    }
                    return false;
                })
                .map(Permission::getRequestUrl)
                .filter(Objects::nonNull)
                .anyMatch(requestUrl -> {
                    // 使用AntPath 匹配
                    if ((requestUrl.contains("/*") || requestUrl.contains("/**"))) {
                        return new AntPathRequestMatcher(requestUrl).matches(request);
                    }
                    // 使用正则匹配（不建议使用）
                    else {
                        return requestURI.matches(requestUrl);
                    }
                });
    }
}
