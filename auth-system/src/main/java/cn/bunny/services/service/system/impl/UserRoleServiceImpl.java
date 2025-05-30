package cn.bunny.services.service.system.impl;

import cn.bunny.services.core.event.event.UpdateUserinfoByUserIdsEvent;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.system.dto.user.AssignRolesToUsersDto;
import cn.bunny.domain.system.entity.AdminUser;
import cn.bunny.domain.system.entity.UserRole;
import cn.bunny.core.exception.AuthCustomerException;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.mapper.system.UserRoleMapper;
import cn.bunny.services.service.system.UserRoleService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
@Transactional
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {

    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private UserMapper userMapper;

    @Resource
    private ApplicationEventPublisher applicationEventPublisher;

    /**
     * * 根据用户id获取角色列表
     *
     * @param userId 用户id
     * @return 角色列表
     */
    @Override
    public List<String> getRoleListByUserId(Long userId) {
        if (userId == null) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        List<UserRole> userRoles = userRoleMapper.selectList(Wrappers.<UserRole>lambdaQuery().eq(UserRole::getUserId, userId));
        return userRoles.stream().map(userRole -> userRole.getRoleId().toString()).toList();
    }

    /**
     * 为用户分配角色
     *
     * @param dto 用户分配角色
     */
    @Override
    public void addUserRole(AssignRolesToUsersDto dto) {
        Long userId = dto.getUserId();
        List<Long> roleIds = dto.getRoleIds();

        // 查询当前用户
        AdminUser adminUser = userMapper.selectOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));
        if (adminUser == null) {
            throw new AuthCustomerException(ResultCodeEnum.USER_IS_EMPTY);
        }

        // 删除这个用户下所有已经分配好的角色内容
        List<Long> ids = List.of(userId);
        baseMapper.deleteBatchIdsByUserIds(ids);

        // 保存分配好的角色信息
        List<UserRole> roleList = roleIds.stream().map(roleId -> {
            UserRole userRole = new UserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(roleId);
            return userRole;
        }).toList();
        saveBatch(roleList);

        // 重新设置Redis中的用户存储信息vo对象
        applicationEventPublisher.publishEvent(new UpdateUserinfoByUserIdsEvent(this, ids));
    }
}
