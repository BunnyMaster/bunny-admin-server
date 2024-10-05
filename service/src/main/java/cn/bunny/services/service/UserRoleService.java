package cn.bunny.services.service;

import cn.bunny.dao.dto.system.user.AssignRolesToUsersDto;
import cn.bunny.dao.entity.system.UserRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
public interface UserRoleService extends IService<UserRole> {

    /**
     * * 为用户分配角色
     *
     * @param dto 用户分配角色
     */
    void assignRolesToUsers(AssignRolesToUsersDto dto);

    /**
     * * 根据用户id获取角色列表
     *
     * @param userId 用户id
     * @return 角色列表
     */
    List<String> getRoleListByUserId(Long userId);
}
