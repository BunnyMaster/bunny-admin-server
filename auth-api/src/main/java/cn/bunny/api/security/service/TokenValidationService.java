package cn.bunny.api.security.service;

import cn.bunny.api.security.exception.CustomAuthenticationException;
import cn.bunny.core.utils.JwtTokenUtil;
import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.dto.security.TokenInfo;
import cn.bunny.domain.common.model.vo.LoginVo;
import com.alibaba.fastjson2.JSON;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

/**
 * 处理Token相关逻辑
 */
@Service
public class TokenValidationService {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    public TokenInfo validateToken(HttpServletRequest request) {
        // 判断是否有 token
        String header = request.getHeader("Authorization" );
        if (header == null || !header.startsWith("Bearer " )) {
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
        Object loginVoObject = redisTemplate.opsForValue().get(RedisUserConstant.getUserLoginInfoPrefix(username));
        LoginVo loginVo = JSON.parseObject(JSON.toJSONString(loginVoObject), LoginVo.class);

        return TokenInfo.builder().userId(userId).username(username).token(token).loginVo(loginVo).build();
    }
}
