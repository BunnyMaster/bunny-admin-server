package cn.bunny.services.security.custom;

import cn.bunny.dao.constant.RedisUserConstant;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.context.BaseContext;
import cn.bunny.services.mapper.system.PowerMapper;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.utils.JwtHelper;
import cn.bunny.services.utils.system.RoleUtil;
import com.alibaba.fastjson2.JSON;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
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

    private final PowerMapper powerMapper;

    private final RoleMapper roleMapper;

    private final RedisTemplate<String, Object> redisTemplate;

    public CustomAuthorizationManagerServiceImpl(PowerMapper powerMapper, RoleMapper roleMapper, RedisTemplate<String, Object> redisTemplate) {
        this.powerMapper = powerMapper;
        this.roleMapper = roleMapper;
        this.redisTemplate = redisTemplate;
    }

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
        // 根据用户ID查询角色数据
        Long userId = BaseContext.getUserId();
        List<Role> roleList = roleMapper.selectListByUserId(userId);

        // 角色代码
        List<String> roleCodeList = roleList.stream().map(Role::getRoleCode).toList();

        // 判断是否是管理员用户
        boolean checkedAdmin = RoleUtil.checkAdmin(roleCodeList);
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
