package cn.bunny.services.security.service.iml;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.services.mapper.PowerMapper;
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
    private final PowerMapper powerMapper;

    public CustomAuthorizationManagerServiceImpl(PowerMapper powerMapper) {this.powerMapper = powerMapper;}

    @Override
    public AuthorizationDecision check(Supplier<Authentication> authentication, RequestAuthorizationContext context) {
        // 用户的token和用户id、请求Url
        HttpServletRequest request = context.getRequest();
        String token = request.getHeader("token");

        // 用户id
        Long userId = JwtHelper.getUserId(token);

        // 请求地址
        String requestURI = request.getRequestURI();

        // 请求方式
        String method = request.getMethod();

        // 角色代码列表
        List<String> roleCodeList = authentication.get().getAuthorities().stream().map(GrantedAuthority::getAuthority).toList();

        // 校验权限
        return new AuthorizationDecision(hasAuth(requestURI, roleCodeList));
    }

    /**
     * 查询用户所属的角色信息
     *
     * @param requestURI   请求url地址
     * @param roleCodeList 角色列表
     */
    private Boolean hasAuth(String requestURI, List<String> roleCodeList) {
        // 判断是否是 admin
        boolean isAdmin = roleCodeList.stream().anyMatch(role -> role.equals("admin"));
        if (isAdmin) return true;

        // 不是 admin，查询角色权限关系表
        List<String> powerCodes = BaseContext.getLoginVo().getPermissions();

        // 根据权限码查询可以访问URL
        List<Power> powerList = powerMapper.selectListByPowerCodes(powerCodes);

        // 判断是否与请求路径匹配
        return powerList.stream().anyMatch(power -> power.getRequestUrl().equals(requestURI));
    }
}
