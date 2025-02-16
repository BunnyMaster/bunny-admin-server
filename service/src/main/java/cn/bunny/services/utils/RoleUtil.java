package cn.bunny.services.utils;

import cn.bunny.dao.constant.RedisUserConstant;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.services.mapper.UserMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RoleUtil {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserFactory userFactory;

    /**
     * 批量更新Redis中用户信息
     *
     * @param userIds 用户Id列表
     */
    public void updateUserRedisInfo(List<Long> userIds) {
        // 根据Id查找所有用户
        List<AdminUser> adminUsers = userMapper.selectList(Wrappers.<AdminUser>lambdaQuery().in(AdminUser::getId, userIds));

        // 用户为空时不更新Redis的key
        if (adminUsers.isEmpty()) return;

        // 更新Redis中用户信息
        adminUsers.stream().filter(user -> {
            String adminLoginInfoPrefix = RedisUserConstant.getAdminLoginInfoPrefix(user.getUsername());
            Object object = redisTemplate.opsForValue().get(adminLoginInfoPrefix);
            return object != null;
        }).forEach(user -> userFactory.buildUserVo(user, RedisUserConstant.REDIS_EXPIRATION_TIME));
    }
}
