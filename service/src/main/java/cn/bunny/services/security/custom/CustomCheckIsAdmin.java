package cn.bunny.services.security.custom;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.dao.entity.system.AdminUser;

import java.util.List;

/**
 * 检查是否是管理员
 */
public class CustomCheckIsAdmin {

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
        if (!isIdAdmin || !isAdmin) {
            roleList.add("admin");
            permissions.add("*");
            permissions.add("*::*");
            permissions.add("*::*::*");
            return true;
        }

        return false;
    }
}
