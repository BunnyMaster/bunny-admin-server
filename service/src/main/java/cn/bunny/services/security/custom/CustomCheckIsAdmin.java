package cn.bunny.services.security.custom;

import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.vo.system.user.LoginVo;

import java.util.List;

/**
 * 检查是否是管理员
 */
public class CustomCheckIsAdmin {
    
    public static boolean checkAdmin(List<String> roleList, LoginVo loginVo) {
        // 判断是否是超级管理员
        if (loginVo.getId().equals(1L)) return true;

        // 判断是否是 admin
        return roleList.stream().anyMatch(role -> role.equals("admin"));
    }

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
