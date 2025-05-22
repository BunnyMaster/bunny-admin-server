package cn.bunny.services.service.system.impl;

import cn.bunny.services.core.cache.RedisService;
import cn.bunny.services.core.event.event.ClearAllUserCacheEvent;
import cn.bunny.services.core.event.event.UpdateUserinfoByUserIdsEvent;
import cn.bunny.services.domain.common.constant.FileStorageConstant;
import cn.bunny.services.domain.common.constant.UserConstant;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.files.dto.FileUploadDto;
import cn.bunny.services.domain.files.vo.FileInfoVo;
import cn.bunny.services.domain.log.entity.UserLoginLog;
import cn.bunny.services.domain.system.dto.user.AdminUserAddDto;
import cn.bunny.services.domain.system.dto.user.AdminUserDto;
import cn.bunny.services.domain.system.dto.user.AdminUserUpdateDto;
import cn.bunny.services.domain.system.entity.AdminUser;
import cn.bunny.services.domain.system.entity.Role;
import cn.bunny.services.domain.system.entity.UserDept;
import cn.bunny.services.domain.system.views.ViewUserDept;
import cn.bunny.services.domain.system.vo.user.AdminUserVo;
import cn.bunny.services.domain.system.vo.user.UserVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.log.UserLoginLogMapper;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.mapper.system.UserDeptMapper;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.mapper.system.UserRoleMapper;
import cn.bunny.services.service.file.FilesService;
import cn.bunny.services.service.system.UserService;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


/**
 * 用户信息 服务实现类
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
@Transactional
public class UserServiceImpl extends ServiceImpl<UserMapper, AdminUser> implements UserService {

    @Resource
    private PasswordEncoder passwordEncoder;

    @Resource
    private FilesService filesService;

    @Resource
    private UserDeptMapper userDeptMapper;

    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private UserLoginLogMapper userLoginLogMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RedisService redisService;

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    @Resource
    private ApplicationEventPublisher applicationEventPublisher;

    /**
     * 获取用户信息
     *
     * @param id 用户id
     * @return 用户信息
     */
    @Override
    public UserVo getUserinfoById(Long id) {
        // 判断请求Id是否为空
        if (id == null) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);
        AdminUser user = getById(id);

        // 用户是否存在
        if (user == null) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);

        UserVo userVo = new UserVo();
        BeanUtils.copyProperties(user, userVo);

        return userVo;
    }

    /**
     * 管理员强制用户下线
     *
     * <p><b>功能说明</b>：管理员强制指定用户退出登录状态，并记录操作日志</p>
     *
     * <p><b>处理流程</b>：</p>
     * <ol>
     *   <li>参数校验：检查用户ID是否为空</li>
     *   <li>查询用户信息：根据ID获取用户实体</li>
     *   <li>记录操作日志：保存强制下线记录到用户登录日志表</li>
     *   <li>清除登录状态：删除Redis中的用户登录信息</li>
     * </ol>
     *
     * @param id 用户ID（不可为空）
     * @see UserConstant#FORCE_LOGOUT 强制下线类型常量
     */
    @Override
    public void forcedOfflineByAdmin(Long id) {
        if (id == null) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 根据id查询用户登录前缀
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, id));

        // 将用户登录保存在用户登录日志表中
        UserLoginLog userLoginLog = new UserLoginLog();
        BeanUtils.copyProperties(adminUser, userLoginLog);
        userLoginLog.setId(null);
        userLoginLog.setUserId(adminUser.getId());
        userLoginLog.setType(UserConstant.FORCE_LOGOUT);
        userLoginLogMapper.insert(userLoginLog);

        // 删除Redis中用户信息
        String username = adminUser.getUsername();
        applicationEventPublisher.publishEvent(new ClearAllUserCacheEvent(this, username));
    }

    /**
     * 查询用户
     *
     * @param keyword 查询用户信息关键字
     * @return 用户信息列表
     */
    @Override
    public List<UserVo> getUserListByKeyword(String keyword) {
        // 如果没有输入，返回前20条用户信息
        if (!StringUtils.hasText(keyword)) {
            Page<AdminUser> page = Page.of(1, 20);
            LambdaQueryWrapper<AdminUser> queryWrapper = Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getStatus, false);

            return list(page, queryWrapper).stream()
                    .map(adminUser -> {
                        UserVo adminUserVo = new UserVo();
                        BeanUtils.copyProperties(adminUser, adminUserVo);
                        return adminUserVo;
                    }).toList();
        }

        List<AdminUser> list = baseMapper.queryUser(keyword);
        return list.stream().map(adminUser -> {
            UserVo adminUserVo = new UserVo();
            BeanUtils.copyProperties(adminUser, adminUserVo);
            return adminUserVo;
        }).toList();
    }

    /**
     * 查询缓存中已登录用户
     *
     * @param pageParams 分页查询
     * @return 分页查询结果
     */
    @Override
    public PageResult<UserVo> getCacheUserPage(Page<AdminUser> pageParams) {
        long pageNum = pageParams.getCurrent();
        long pageSize = pageParams.getSize();
        List<String> keys = redisService.scannerRedisKeyByPage(pageNum, pageSize);

        List<UserVo> list = keys.stream().map(key -> {
            Object loginVoObject = redisTemplate.opsForValue().get(key);
            LoginVo loginVo = JSON.parseObject(JSON.toJSONString(loginVoObject), LoginVo.class);

            UserVo userVo = new UserVo();
            BeanUtils.copyProperties(loginVo, userVo);
            userVo.setSummary(loginVo.getPersonDescription());
            return userVo;
        }).toList();

        return PageResult.<UserVo>builder()
                .pageNo(pageNum).pageSize(pageSize)
                .list(list).total((long) keys.size())
                .build();
    }

    /**
     * 用户信息 服务实现类
     *
     * @param pageParams 用户信息分页查询page对象
     * @param dto        用户信息分页查询对象
     * @return 查询分页用户信息返回对象
     */
    @Override
    public PageResult<AdminUserVo> getUserPageByAdmin(Page<AdminUser> pageParams, AdminUserDto dto) {
        IPage<ViewUserDept> page = baseMapper.selectListByPage(pageParams, dto);

        List<AdminUserVo> voList = page.getRecords().stream()
                .map(adminUser -> {
                    AdminUserVo adminUserVo = new AdminUserVo();
                    BeanUtils.copyProperties(adminUser, adminUserVo);
                    return adminUserVo;
                })
                .filter(adminUserVo -> !adminUserVo.getId().equals(1L))
                .toList();

        return PageResult.<AdminUserVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加用户信息
     * 需要确认用户名-username是唯一的
     * 需要确认邮箱-email是唯一的
     *
     * @param dto 用户信息添加
     */
    @Override
    public void createUserByAdmin(AdminUserAddDto dto) {
        // 对密码加密
        String encodePassword = passwordEncoder.encode(dto.getPassword());

        // 保存数据
        AdminUser adminUser = new AdminUser();
        BeanUtils.copyProperties(dto, adminUser);
        adminUser.setPassword(encodePassword);
        save(adminUser);

        // 插入用户部门关系表
        Long userId = adminUser.getId();
        Long deptId = dto.getDeptId();
        UserDept userDept = new UserDept();
        userDept.setDeptId(deptId);
        userDept.setUserId(userId);

        // 插入分配后的用户内容
        userDeptMapper.insert(userDept);
    }

    /**
     * 更新用户信息
     * 如果更新了用户名需要用户重新登录，因为Redis中的key已经被删除
     *
     * @param dto 用户信息更新
     */
    @Override
    public void updateUserByAdmin(AdminUserUpdateDto dto) {
        Long userId = dto.getId();

        // 判断更新内容是否存在
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));
        if (adminUser == null) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);

        // 更新用户
        BeanUtils.copyProperties(dto, adminUser);

        // 部门Id
        Long deptId = dto.getDeptId();
        if (deptId != null) {
            // 更新用户部门
            UserDept userDept = new UserDept();
            userDept.setDeptId(deptId);
            userDept.setUserId(userId);
            // 删除这个用户部门关系下所有
            userDeptMapper.deleteBatchIdsByUserIds(List.of(userId));
            // 插入分配后的用户内容
            userDeptMapper.insert(userDept);
        }

        // 更新头像
        uploadAvatarByAdmin(dto, adminUser);

        // 更新密码，放在最后，如果更新密码就将密码删除
        updateUserPasswordByAdmin(adminUser);

        // 更新用户信息
        updateById(adminUser);

        // 同步到 Redis
        List<Long> ids = List.of(adminUser.getId());
        applicationEventPublisher.publishEvent(new UpdateUserinfoByUserIdsEvent(this, ids));
    }

    /**
     * 删除|批量删除用户信息
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteUserByAdmin(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 根据用户Id列表查询用户角色
        List<Role> list = roleMapper.selectListByUserIds(ids);
        List<Role> roleList = list.stream().filter(role -> role.getRoleCode().equals("admin") || ids.contains(1L)).toList();
        if (!roleList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.ADMIN_ROLE_CAN_NOT_DELETED);

        // 清除Redis中数据
        applicationEventPublisher.publishEvent(new UpdateUserinfoByUserIdsEvent(this, ids));

        // 删除部门相关
        userDeptMapper.deleteBatchIdsByUserIds(ids);

        // 删除用户角色相关
        userRoleMapper.deleteBatchIdsByUserIds(ids);

        // 逻辑删除
        removeByIds(ids);
    }

    /**
     * 管理员修改管理员用户密码
     *
     * @param adminUser 管理员用户修改密码
     */
    private void updateUserPasswordByAdmin(AdminUser adminUser) {
        Long userId = adminUser.getId();
        String password = adminUser.getPassword();

        // 密码更新是否存在
        if (!StringUtils.hasText(password)) return;

        // 对密码加密
        String encode = passwordEncoder.encode(password);

        // 判断新密码是否与旧密码相同
        if (adminUser.getPassword().equals(encode)) {
            throw new AuthCustomerException(ResultCodeEnum.UPDATE_NEW_PASSWORD_SAME_AS_OLD_PASSWORD);
        }

        // 更新用户密码
        adminUser.setPassword(encode);
        adminUser.setId(userId);
    }

    /**
     * 管理员上传用户头像
     *
     * @param dto 管理员用户修改头像
     */
    private void uploadAvatarByAdmin(AdminUserUpdateDto dto, AdminUser adminUser) {
        MultipartFile avatar = dto.getAvatar();
        Long userId = dto.getId();

        // 上传头像是否存在
        if (avatar == null) return;

        // 上传头像
        FileUploadDto uploadDto = FileUploadDto.builder().file(avatar).type(FileStorageConstant.AVATAR).build();
        FileInfoVo fileInfoVo = filesService.upload(uploadDto);

        // 更新用户
        adminUser.setId(userId);
        adminUser.setAvatar(fileInfoVo.getUrl());
    }
}
