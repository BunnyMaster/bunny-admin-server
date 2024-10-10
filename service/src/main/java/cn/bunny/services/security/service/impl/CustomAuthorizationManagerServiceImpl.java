package cn.bunny.services.security.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.ResponseUtil;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.security.custom.CustomCheckIsAdmin;
import com.alibaba.fastjson2.JSON;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private PowerMapper powerMapper;

    @SneakyThrows
    @Override
    public AuthorizationDecision check(Supplier<Authentication> authentication, RequestAuthorizationContext context) {
        // 用户的token和用户id、请求Url
        HttpServletRequest request = context.getRequest();

        // 是否访问的是接口内容
        boolean matches = AntPathRequestMatcher.antMatcher("/admin/**").matches(request);
        if (!matches) return new AuthorizationDecision(true);

        if (checkToken(request)) {
            return new AuthorizationDecision(true);
        }
        
        // 校验权限
        return new AuthorizationDecision(hasAuth(request));
    }

    private boolean checkToken(HttpServletRequest request) {
        HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getResponse();
        if (response == null) return false;

        // 判断是否有 token
        String token = request.getHeader("token");
        if (token == null) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.LOGIN_AUTH));
            return false;
        }

        // 判断 token 是否过期
        if (JwtHelper.isExpired(token)) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.AUTHENTICATION_EXPIRED));
            return false;
        }

        // 查找 Redis
        String username = JwtHelper.getUsername(token);
        Long userId = JwtHelper.getUserId(token);
        Object loginVoObject = redisTemplate.opsForValue().get(RedisUserConstant.getAdminLoginInfoPrefix(username));
        LoginVo loginVo = JSON.parseObject(JSON.toJSONString(loginVoObject), LoginVo.class);

        // 判断用户是否禁用
        if (loginVo != null && loginVo.getStatus()) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED));
            return false;
        }

        // 设置用户信息
        BaseContext.setUsername(username);
        BaseContext.setUserId(userId);
        BaseContext.setLoginVo(loginVo);
        return true;
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
