package cn.bunny.services.service.system.impl;

import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.system.system.dto.user.AssignRolesToUsersDto;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.entity.UserRole;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.context.BaseContext;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.mapper.system.UserRoleMapper;
import cn.bunny.services.service.system.UserRoleService;
import cn.bunny.services.utils.system.UserUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.TimeUnit;

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
    private UserUtil userUtil;

    @Resource
    private UserMapper userMapper;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

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
     * * 为用户分配角色
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
        baseMapper.deleteBatchIdsByUserIds(List.of(userId));

        // 保存分配好的角色信息
        List<UserRole> roleList = roleIds.stream().map(roleId -> {
            UserRole userRole = new UserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(roleId);
            return userRole;
        }).toList();
        saveBatch(roleList);

        // 获取记住我时间
        LoginVo loginVo = BaseContext.getLoginVo();
        Long readMeDay = loginVo != null ? loginVo.getReadMeDay() : RedisUserConstant.REDIS_EXPIRATION_TIME;

        // 重新设置Redis中的用户存储信息vo对象
        String username = adminUser.getUsername();
        loginVo = userUtil.buildLoginUserVo(adminUser, readMeDay);
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(username), loginVo, readMeDay, TimeUnit.DAYS);
    }
}
