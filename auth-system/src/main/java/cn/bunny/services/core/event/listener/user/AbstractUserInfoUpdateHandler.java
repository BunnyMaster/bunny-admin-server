package cn.bunny.services.core.event.listener.user;

import cn.bunny.services.core.cache.UserCacheCleaner;
import cn.bunny.domain.common.constant.RedisUserConstant;
import cn.bunny.domain.system.entity.AdminUser;
import cn.bunny.services.mapper.system.UserMapper;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.function.Consumer;

@Component("AbstractUserInfoUpdateHandler")
public abstract class AbstractUserInfoUpdateHandler {

    @Resource
    protected UserMapper userMapper;

    @Resource
    protected UserCacheCleaner userCacheCleaner;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    public void processUserUpdate(List<Long> userIds, Consumer<AdminUser> postProcess) {
        if (userIds.isEmpty()) return;

        List<AdminUser> adminUsers = userMapper.selectBatchIds(userIds);
        adminUsers.stream()
                .filter(user -> redisTemplate.hasKey(RedisUserConstant.getUserLoginInfoPrefix(user.getUsername())))
                .forEach(postProcess);
    }
}