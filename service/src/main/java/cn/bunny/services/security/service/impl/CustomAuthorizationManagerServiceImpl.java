package cn.bunny.services.security.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.mapper.PowerMapper;
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
        // 角色代码列表
        LoginVo loginVo = BaseContext.getLoginVo();
        List<String> roleCodeList = loginVo.getRoles();

        // 判断是否是管理员用户
        boolean checkedAdmin = CustomCheckIsAdmin.checkAdmin(roleCodeList, loginVo);
        if (checkedAdmin) return true;

        // 不是 admin，查询角色权限关系表
        List<String> powerCodes = loginVo.getPermissions();

        // 根据权限码查询可以访问URL
        List<Power> powerList = powerMapper.selectListByPowerCodes(powerCodes);

        // 判断是否与请求路径匹配
        return powerList.stream().anyMatch(power -> AntPathRequestMatcher.antMatcher(power.getRequestUrl()).matches(request) ||
                request.getRequestURI().matches(power.getRequestUrl()));
    }
}
