package cn.bunny.services.security.service;

import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.security.TokenInfo;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.security.exception.CustomAuthenticationException;
import cn.bunny.services.utils.JwtTokenUtil;
import com.alibaba.fastjson2.JSON;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

/**
 * 处理Token相关逻辑
 */
@Component
public class TokenValidationService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    public TokenInfo validateToken(HttpServletRequest request) {
        // 判断是否有 token
        String header = request.getHeader("Authorization");
        if (header == null || !header.startsWith("Bearer ")) {
            throw new CustomAuthenticationException(ResultCodeEnum.LOGIN_AUTH);
        }

        String token = header.substring(7);
        // 判断 token 是否过期
        if (JwtTokenUtil.isExpired(token)) {
            throw new CustomAuthenticationException(ResultCodeEnum.AUTHENTICATION_EXPIRED);
        }

        // 解析JWT中的用户名
        String username = JwtTokenUtil.getUsername(token);
        Long userId = JwtTokenUtil.getUserId(token);

        // 查找 Redis
        Object loginVoObject = redisTemplate.opsForValue().get(RedisUserConstant.getAdminLoginInfoPrefix(username));
        LoginVo loginVo = JSON.parseObject(JSON.toJSONString(loginVoObject), LoginVo.class);

        return TokenInfo.builder().userId(userId).username(username).token(token).loginVo(loginVo).build();
    }
}
