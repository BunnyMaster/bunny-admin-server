package cn.bunny.services.utils.system;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.constant.SecurityConfigConstant;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.service.system.helper.UserLoginHelper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RoleUtil {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Resource
    private UserMapper userMapper;

    @Resource
    private UserLoginHelper userloginHelper;

    /**
     * 判断用户是否具有管理员权限
     * <p>
     * 管理员判定规则：
     * 1. 系统默认管理员：用户ID为1的预设管理员账号（用户名为Administrator）
     * 2. 角色授权管理员：用户角色列表包含"admin"角色的账号
     * <p>
     * 权限控制说明：
     * - 管理员权限用于前端按钮级权限控制，支持以下通配符格式：
     * - "*::*::*"：全部模块的全部操作权限
     * - "*::*"    ：指定模块的全部操作权限
     * - "*"       ：基础通配权限
     * - 若无细粒度按钮控制需求，可不设置具体权限
     * 详细查看
     * <a href="https://pure-admin.cn/pages/RBAC/#%E7%AC%AC%E4%BA%8C%E7%A7%8D%E6%A8%A1%E5%BC%8F-%E7%99%BB%E5%BD%95%E6%8E%A5%E5%8F%A3%E8%BF%94%E5%9B%9E%E6%8C%89%E9%92%AE%E7%BA%A7%E5%88%AB%E6%9D%83%E9%99%90">
     * 查看前端权限设置
     * </a>
     *
     * @param roleList    用户角色编码列表（可能包含"admin"角色）
     * @param permissions 用户权限列表（用于前端按钮控制）
     * @param adminUser   用户实体对象（需包含userId字段）
     * @return true-是管理员，false-非管理员
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
        // 可以放行的权限
        List<String> permitAllList = SecurityConfigConstant.PERMIT_ALL_LIST;

        // 判断是否是超级管理员
        if (BaseContext.getUserId().equals(1L)) return true;

        // 判断是否是 admin
        return roleList.stream().anyMatch(permitAllList::contains);
    }

    /**
     * 批量更新Redis中用户信息
     *
     * @param userIds 用户Id列表
     */
    public void updateUserRedisInfo(List<Long> userIds) {
        if (userIds.isEmpty()) return;

        // 根据Id查找所有用户
        List<AdminUser> adminUsers = userMapper.selectList(Wrappers.<AdminUser>lambdaQuery().in(AdminUser::getId, userIds));

        // 用户为空时不更新Redis的key
        if (adminUsers.isEmpty()) return;

        // 更新Redis中用户信息
        adminUsers.stream()
                .filter(user -> {
                    String adminLoginInfoPrefix = RedisUserConstant.getAdminLoginInfoPrefix(user.getUsername());
                    Object object = redisTemplate.opsForValue().get(adminLoginInfoPrefix);
                    return object != null;
                })
                .forEach(user -> userloginHelper.buildLoginUserVo(user, RedisUserConstant.REDIS_EXPIRATION_TIME));
    }
}
