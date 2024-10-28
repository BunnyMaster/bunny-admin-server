package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.rolePower.role.RoleAddDto;
import cn.bunny.dao.dto.system.rolePower.role.RoleDto;
import cn.bunny.dao.dto.system.rolePower.role.RoleUpdateDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.entity.system.UserRole;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.rolePower.RoleVo;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.*;
import cn.bunny.services.service.RoleService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 角色 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 14:26:24
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private RolePowerMapper rolePowerMapper;

    @Autowired
    private RouterRoleMapper routerRoleMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private UserFactory userFactory;


    /**
     * * 角色 服务实现类
     *
     * @param pageParams 角色分页查询page对象
     * @param dto        角色分页查询对象
     * @return 查询分页角色返回对象
     */
    @Override
    public PageResult<RoleVo> getRoleList(Page<Role> pageParams, RoleDto dto) {
        // 分页查询菜单图标
        IPage<Role> page = baseMapper.selectListByPage(pageParams, dto);

        List<RoleVo> voList = page.getRecords().stream().map(Role -> {
            RoleVo RoleVo = new RoleVo();
            BeanUtils.copyProperties(Role, RoleVo);
            return RoleVo;
        }).toList();

        return PageResult.<RoleVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 获取所有角色
     *
     * @return 所有角色列表
     */
    @Override
    @Cacheable(cacheNames = "role", key = "'allRole'", cacheManager = "cacheManagerWithMouth")
    public List<RoleVo> getAllRoles() {
        return list().stream().map(role -> {
            RoleVo roleVo = new RoleVo();
            BeanUtils.copyProperties(role, roleVo);
            return roleVo;
        }).toList();
    }

    /**
     * 添加角色
     *
     * @param dto 角色添加
     */
    @Override
    @CacheEvict(cacheNames = "role", key = "'allRole'", beforeInvocation = true)
    public void addRole(@Valid RoleAddDto dto) {
        Role role = new Role();
        BeanUtils.copyProperties(dto, role);
        save(role);
    }

    /**
     * 更新角色
     *
     * @param dto 角色更新
     */
    @Override
    @CacheEvict(cacheNames = "role", key = "'allRole'", beforeInvocation = true)
    public void updateRole(@Valid RoleUpdateDto dto) {
        // 查询更新的角色是否存在
        List<Role> roleList = list(Wrappers.<Role>lambdaQuery().eq(Role::getId, dto.getId()));
        if (roleList.isEmpty()) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);

        // 更新内容
        Role role = new Role();
        BeanUtils.copyProperties(dto, role);
        updateById(role);

        // 找到所有和当前更新角色相同的用户
        List<Long> userIds = userRoleMapper.selectList(Wrappers.<UserRole>lambdaQuery().eq(UserRole::getRoleId, dto.getId()))
                .stream().map(UserRole::getUserId).toList();

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

    /**
     * 删除|批量删除角色
     *
     * @param ids 删除id列表
     */
    @Override
    @CacheEvict(cacheNames = "role", key = "'allRole'", beforeInvocation = true)
    public void deleteRole(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 删除角色
        baseMapper.deleteBatchIdsWithPhysics(ids);

        // 删除角色权限相关
        rolePowerMapper.deleteBatchRoleIdsWithPhysics(ids);

        // 删除角色和用户相关
        userRoleMapper.deleteBatchIdsByRoleIdsWithPhysics(ids);

        // 删除角色和路由相关
        routerRoleMapper.deleteBatchIdsByRoleIdsWithPhysics(ids);
    }
}
