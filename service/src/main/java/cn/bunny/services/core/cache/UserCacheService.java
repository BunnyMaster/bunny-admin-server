package cn.bunny.services.core.cache;

import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import com.alibaba.fastjson2.JSON;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class UserCacheService {
    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 根据用户名获取缓存中内容
     *
     * @param username 用户名
     * @return LoginVo
     */
    public LoginVo getLoginVoByUsername(String username) {
        Object loginVoObject = redisTemplate.opsForValue().get(RedisUserConstant.getUserLoginInfoPrefix(username));
        return JSON.parseObject(JSON.toJSONString(loginVoObject), LoginVo.class);
    }
}
