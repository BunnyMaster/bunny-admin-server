package cn.bunny.services.security.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.mapper.RoleMapper;
import cn.bunny.services.security.custom.CustomCheckIsAdmin;
import jakarta.servlet.http.HttpServletRequest;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Component;

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

    @Autowired
    private PowerMapper powerMapper;

    @Autowired
    private RoleMapper roleMapper;

    @SneakyThrows
    @Override
    public AuthorizationDecision check(Supplier<Authentication> authentication, RequestAuthorizationContext context) {
        // 用户的token和用户id、请求Url
        HttpServletRequest request = context.getRequest();

        // 校验权限
        return new AuthorizationDecision(hasAuth(request));
    }

    /**
     * 查询用户所属的角色信息
     *
     * @param request 请求url地址
     */
    private Boolean hasAuth(HttpServletRequest request) {
        // 根据用户ID查询角色数据
        Long userId = BaseContext.getUserId();
        List<Role> roleList = roleMapper.selectListByUserId(userId);

        // 角色代码
        List<String> roleCodeList = roleList.stream().map(Role::getRoleCode).toList();

        // 判断是否是管理员用户
        boolean checkedAdmin = CustomCheckIsAdmin.checkAdmin(roleCodeList);
        if (checkedAdmin) return true;

        // 判断请求地址是否是 noManage 不需要被验证的
        String requestURI = request.getRequestURI();
        if (requestURI.contains("noManage")) return true;

        // 根据角色列表查询权限信息
        List<Power> powerList = powerMapper.selectListByUserId(userId);

        // 判断是否与请求路径匹配
        return powerList.stream().map(Power::getRequestUrl)
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
