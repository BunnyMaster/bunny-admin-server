package cn.bunny.services.utils.system;

import cn.bunny.dao.constant.RedisUserConstant;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.services.context.BaseContext;
import cn.bunny.services.mapper.system.UserMapper;
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
    private UserUtil userUtil;

    /**
     * 判断是否是管理员
     *
     * @param roleList    角色代码列表
     * @param permissions 权限列表
     * @param adminUser   用户信息
     * @return 是否是管理员
     */
    public static boolean checkAdmin(List<String> roleList, List<String> permissions, AdminUser adminUser) {
        // 判断是否是超级管理员
        boolean isIdAdmin = adminUser.getId().equals(1L);
        boolean isAdmin = roleList.stream().anyMatch(role -> role.equals("admin"));

        // 判断是否是 admin
        if (isIdAdmin || isAdmin) {
            roleList.add("admin");
            permissions.add("*");
            permissions.add("*::*");
            permissions.add("*::*::*");
            return true;
        }

        return false;
    }

    /**
     * 判断是否是管理员
     *
     * @param roleList 角色代码列表
     * @return 是否是管理员
     */
    public static boolean checkAdmin(List<String> roleList) {
        // 判断是否是超级管理员
        if (BaseContext.getUserId().equals(1L)) return true;

        // 判断是否是 admin
        return roleList.stream().anyMatch(role -> role.equals("admin"));
    }

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
        }).forEach(user -> userUtil.buildUserVo(user, RedisUserConstant.REDIS_EXPIRATION_TIME));
    }
}
