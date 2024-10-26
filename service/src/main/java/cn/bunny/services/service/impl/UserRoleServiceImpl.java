package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.user.AssignRolesToUsersDto;
import cn.bunny.dao.entity.system.UserRole;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.services.mapper.UserRoleMapper;
import cn.bunny.services.service.UserRoleService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
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

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;


    /**
     * * 根据用户id获取角色列表
     *
     * @param userId 用户id
     * @return 角色列表
     */
    @Override
    public List<String> getRoleListByUserId(Long userId) {
        if (userId == null) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);

        List<UserRole> userRoles = userRoleMapper.selectList(Wrappers.<UserRole>lambdaQuery().eq(UserRole::getUserId, userId));
        return userRoles.stream().map(userRole -> userRole.getRoleId().toString()).toList();
    }

    /**
     * * 为用户分配角色
     *
     * @param dto 用户分配角色
     */
    @Override
    public void assignRolesToUsers(AssignRolesToUsersDto dto) {
        Long userId = dto.getUserId();
        List<Long> roleIds = dto.getRoleIds();

        // 删除这个用户下所有已经分配好的角色内容
        baseMapper.deleteBatchIdsByUserIdsWithPhysics(List.of(userId));

        // 保存分配好的角色信息
        List<UserRole> roleList = roleIds.stream().map(roleId -> {
            UserRole userRole = new UserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(roleId);
            return userRole;
        }).toList();
        saveBatch(roleList);
    }
}
