package cn.bunny.services.core.cache;

import cn.bunny.domain.common.constant.RedisUserConstant;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

@Component
public class UserCacheCleaner {
    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    public void cleanUserLoginCache(String username) {
        String key = RedisUserConstant.getUserLoginInfoPrefix(username);
        redisTemplate.delete(key);
    }

    public void cleanUserRoleCache(String username) {
        String key = RedisUserConstant.getUserRolesCodePrefix(username);
        redisTemplate.delete(key);
    }

    public void cleanUserPermissionCache(String username) {
        String key = RedisUserConstant.getUserPermissionCodePrefix(username);
        redisTemplate.delete(key);
    }

    public void cleanAllUserCache(String username) {
        cleanUserLoginCache(username);
        cleanUserRoleCache(username);
        cleanUserPermissionCache(username);
    }
}