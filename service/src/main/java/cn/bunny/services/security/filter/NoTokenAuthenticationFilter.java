package cn.bunny.services.security.filter;


import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.ResponseUtil;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.user.LoginVo;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

public class NoTokenAuthenticationFilter extends OncePerRequestFilter {
    private final RedisTemplate<String, Object> redisTemplate;

    public NoTokenAuthenticationFilter(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // 判断是否有 token
        String token = request.getHeader("token");
        if (token == null) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.LOGIN_AUTH));
            return;
        }

        // 判断 token 是否过期
        boolean expired = JwtHelper.isExpired(token);
        if (expired) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.AUTHENTICATION_EXPIRED));
            return;
        }

        // token 存在查找 Redis
        String username = JwtHelper.getUsername(token);
        Long userId = JwtHelper.getUserId(token);
        LoginVo loginVo = (LoginVo) redisTemplate.opsForValue().get(RedisUserConstant.getAdminLoginInfoPrefix(username));

        // 判断用户是否禁用
        if (loginVo != null && loginVo.getStatus() == 1) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED));
            return;
        }

        // 设置用户信息
        BaseContext.setUsername(username);
        BaseContext.setUserId(userId);
        BaseContext.setLoginVo(loginVo);

        // 执行下一个过滤器
        doFilter(request, response, filterChain);
    }
}