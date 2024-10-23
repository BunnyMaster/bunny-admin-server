package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.ip.IpUtil;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.dto.system.files.FileUploadDto;
import cn.bunny.dao.dto.system.user.*;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.AdminUserAndDept;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.entity.system.UserDept;
import cn.bunny.dao.pojo.constant.MinioConstant;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.enums.EmailTemplateEnums;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.files.FileInfoVo;
import cn.bunny.dao.vo.system.user.AdminUserVo;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.dao.vo.system.user.RefreshTokenVo;
import cn.bunny.dao.vo.system.user.UserVo;
import cn.bunny.services.factory.EmailFactory;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.*;
import cn.bunny.services.service.FilesService;
import cn.bunny.services.service.UserService;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import lombok.SneakyThrows;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
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

    @Autowired
    private UserFactory userFactory;

    @Autowired
    private EmailFactory emailFactory;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private MinioUtil minioUtil;

    @Autowired
    private FilesService filesService;

    @Autowired
    private UserDeptMapper userDeptMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Autowired
    private UserLoginLogMapper userLoginLogMapper;

    @Autowired
    private EmailTemplateMapper emailTemplateMapper;

    /**
     * 登录发送邮件验证码
     *
     * @param email 邮箱
     */
    @Override
    public void sendLoginEmail(@NotNull String email) {
        // 查询验证码邮件模板
        LambdaQueryWrapper<EmailTemplate> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(EmailTemplate::getIsDefault, true);
        lambdaQueryWrapper.eq(EmailTemplate::getType, EmailTemplateEnums.VERIFICATION_CODE.getType());
        EmailTemplate emailTemplate = emailTemplateMapper.selectOne(lambdaQueryWrapper);

        // 生成验证码
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(150, 48, 4, 2);
        String emailCode = captcha.getCode();

        // 需要替换模板内容
        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("#title#", "BunnyAdmin");
        hashMap.put("#verifyCode#", emailCode);
        hashMap.put("#expires#", 15);
        hashMap.put("#sendEmailUser#", emailTemplate.getEmailUser());
        hashMap.put("#companyName#", "BunnyAdmin");

        // 发送邮件
        emailFactory.sendEmailTemplate(email, emailTemplate, hashMap);

        // 在Redis中存储验证码
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminUserEmailCodePrefix(email), emailCode);
    }

    /**
     * 刷新用户token
     *
     * @param dto 请求token
     * @return 刷新token返回内容
     */
    @NotNull
    @Override
    public RefreshTokenVo refreshToken(@NotNull RefreshTokenDto dto) {
        Long userId = JwtHelper.getUserId(dto.getRefreshToken());
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));

        if (adminUser == null) throw new BunnyException(ResultCodeEnum.FAIL_REQUEST_NOT_AUTH);
        if (adminUser.getStatus()) throw new BunnyException(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED);

        LoginVo buildUserVo = userFactory.buildUserVo(adminUser, dto.getReadMeDay());
        RefreshTokenVo refreshTokenVo = new RefreshTokenVo();
        BeanUtils.copyProperties(buildUserVo, refreshTokenVo);

        return refreshTokenVo;
    }

    /**
     * 退出登录
     */
    @Override
    public void logout() {
        LoginVo loginVo = BaseContext.getLoginVo();
        Long id = loginVo.getId();

        // 获取IP地址
        String ipAddr = IpUtil.getCurrentUserIpAddress().getIpAddr();
        String ipRegion = IpUtil.getCurrentUserIpAddress().getIpRegion();

        // 查询用户信息
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, id));
        UserLoginLog userLoginLog = userFactory.setUserLoginLog(adminUser, loginVo.getToken(), ipAddr, ipRegion, "logout");
        userLoginLogMapper.insert(userLoginLog);

        // 删除Redis中用户信息
        redisTemplate.delete(RedisUserConstant.getAdminLoginInfoPrefix(loginVo.getUsername()));
    }

    /**
     * * 获取用户信息
     *
     * @param id 用户id
     * @return 用户信息
     */
    @Override
    public UserVo getUserinfoById(Long id) {
        // 判断请求Id是否为空
        if (id == null) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);
        AdminUser user = getById(id);

        // 用户是否存在
        if (user == null) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);

        // 用户头像
        String avatar = user.getAvatar();
        UserVo userVo = new UserVo();
        BeanUtils.copyProperties(user, userVo);

        if (StringUtils.hasText(avatar)) userVo.setAvatar(minioUtil.getObjectNameFullPath(avatar));
        return userVo;
    }

    /**
     * * 管理员修改管理员用户密码
     *
     * @param dto 管理员用户修改密码
     */
    @Override
    public void updateUserPasswordByAdmin(AdminUserUpdateWithPasswordDto dto) {
        Long userId = dto.getUserId();
        String password = dto.getPassword();

        // 对密码加密
        String md5Password = DigestUtils.md5DigestAsHex(password.getBytes());
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));

        // 判断是否存在这个用户
        if (adminUser == null) throw new BunnyException(ResultCodeEnum.USER_IS_EMPTY);

        // 判断新密码是否与旧密码相同
        if (adminUser.getPassword().equals(md5Password))
            throw new BunnyException(ResultCodeEnum.UPDATE_NEW_PASSWORD_SAME_AS_OLD_PASSWORD);

        // 删除Redis中登录用户信息
        redisTemplate.delete(RedisUserConstant.getAdminLoginInfoPrefix(adminUser.getEmail()));

        // 更新用户密码
        adminUser = new AdminUser();
        adminUser.setPassword(md5Password);
        adminUser.setId(userId);
        updateById(adminUser);
    }

    /**
     * * 管理员上传用户头像
     *
     * @param dto 管理员用户修改头像
     */
    @SneakyThrows
    @Override
    public void uploadAvatarByAdmin(UserUpdateWithAvatarDto dto) {
        MultipartFile avatar = dto.getAvatar();
        Long userId = dto.getUserId();

        // 判断是否存在这个用户
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));
        if (adminUser == null) throw new BunnyException(ResultCodeEnum.USER_IS_EMPTY);

        // 上传头像
        FileUploadDto uploadDto = FileUploadDto.builder().file(avatar).type(MinioConstant.avatar).build();
        FileInfoVo fileInfoVo = filesService.upload(uploadDto);

        // 更新用户
        adminUser = new AdminUser();
        adminUser.setId(userId);
        adminUser.setAvatar(fileInfoVo.getFilepath());
        updateById(adminUser);
    }

    /**
     * * 强制退出
     *
     * @param id 用户id
     */
    @Override
    public void forcedOffline(Long id) {
        if (id == null) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 根据id查询用户登录前缀
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, id));
        String email = adminUser.getEmail();
        String adminLoginInfoPrefix = RedisUserConstant.getAdminLoginInfoPrefix(email);

        // 将用户登录保存在用户登录日志表中
        UserLoginLog userLoginLog = new UserLoginLog();
        userLoginLog.setUserId(adminUser.getId());
        userLoginLog.setIpAddress(adminUser.getIpAddress());
        userLoginLog.setIpRegion(adminUser.getIpRegion());
        userLoginLog.setToken(null);
        userLoginLog.setType("forcedOffline");
        userLoginLogMapper.insert(userLoginLog);

        // 删除Redis中用户信息
        redisTemplate.delete(adminLoginInfoPrefix);
    }

    /**
     * * 查询用户
     *
     * @param keyword 查询用户信息关键字
     * @return 用户信息列表
     */
    @Override
    public List<AdminUserVo> queryUser(String keyword) {
        if (!StringUtils.hasText(keyword)) return new ArrayList<>();

        List<AdminUser> list = baseMapper.queryUser(keyword);
        return list.stream().map(adminUser -> {
            AdminUserVo adminUserVo = new AdminUserVo();
            BeanUtils.copyProperties(adminUser, adminUserVo);
            return adminUserVo;
        }).toList();
    }

    /**
     * * 修改用户状态
     *
     * @param dto 管理员用户修改状态
     */
    @Override
    public void updateUserStatusByAdmin(AdminUserUpdateUserStatusDto dto) {
        AdminUser adminUser = new AdminUser();
        adminUser.setId(dto.getUserId());
        adminUser.setStatus(dto.getStatus());

        updateById(adminUser);
    }

    /**
     * * 获取本地登录用户信息
     *
     * @return 用户信息
     */
    @Override
    public UserVo getUserinfo() {
        // 查询当前用户信息
        Long userId = BaseContext.getUserId();
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));

        // 赋值对象
        UserVo userVo = new UserVo();
        BeanUtils.copyProperties(adminUser, userVo);

        // 设置用户头像内容
        String avatar = adminUser.getAvatar();
        if (StringUtils.hasText(avatar)) userVo.setAvatar(minioUtil.getObjectNameFullPath(avatar));
        return userVo;
    }

    /**
     * * 更新本地用户信息
     *
     * @param dto 用户信息
     */
    @Override
    public void updateAdminUserByLocalUser(AdminUserUpdateByLocalUserDto dto) {
        Long userId = BaseContext.getUserId();

        // 判断是否存在这个用户
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));
        if (adminUser == null) throw new BunnyException(ResultCodeEnum.USER_IS_EMPTY);

        // 检查用户头像
        dto.setAvatar(userFactory.checkUserAvatar(dto.getAvatar()));

        // 更新用户
        adminUser = new AdminUser();
        adminUser.setId(userId);
        BeanUtils.copyProperties(dto, adminUser);

        updateById(adminUser);
    }

    /**
     * * 更新本地用户密码
     *
     * @param password 更新本地用户密码
     */
    @Override
    public void updateUserPasswordByLocalUser(@Valid String password) {
        // 根据当前用户查询用户信息
        Long userId = BaseContext.getUserId();
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));

        // 判断用户是否存在
        if (adminUser == null) throw new BunnyException(ResultCodeEnum.USER_IS_EMPTY);

        // 数据库中的密码
        String dbPassword = adminUser.getPassword();
        password = DigestUtils.md5DigestAsHex(password.getBytes());

        // 判断数据库中密码是否和更新用户密码相同
        if (dbPassword.equals(password)) throw new BunnyException(ResultCodeEnum.NEW_PASSWORD_SAME_OLD_PASSWORD);

        // 删除Redis中登录用户信息
        redisTemplate.delete(RedisUserConstant.getAdminLoginInfoPrefix(adminUser.getEmail()));

        // 更新用户密码
        adminUser = new AdminUser();
        adminUser.setId(userId);
        adminUser.setPassword(password);
        updateById(adminUser);


    }

    /**
     * * 用户信息 服务实现类
     *
     * @param pageParams 用户信息分页查询page对象
     * @param dto        用户信息分页查询对象
     * @return 查询分页用户信息返回对象
     */
    @Override
    public PageResult<AdminUserVo> getAdminUserList(Page<AdminUser> pageParams, AdminUserDto dto) {
        // 分页查询菜单图标
        IPage<AdminUserAndDept> page = baseMapper.selectListByPage(pageParams, dto);

        List<AdminUserVo> voList = page.getRecords().stream().map(AdminUser -> {
            // 如果存在用户头像，则设置用户头像
            String avatar = AdminUser.getAvatar();
            if (StringUtils.hasText(avatar)) {
                avatar = minioUtil.getObjectNameFullPath(avatar);
            }

            AdminUserVo adminUserVo = new AdminUserVo();
            BeanUtils.copyProperties(AdminUser, adminUserVo);
            adminUserVo.setAvatar(avatar);
            return adminUserVo;
        }).toList();

        return PageResult.<AdminUserVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加用户信息
     *
     * @param dto 用户信息添加
     */
    @Override
    public void addAdminUser(@Valid AdminUserAddDto dto) {
        // 对密码加密
        String md5Password = DigestUtils.md5DigestAsHex(dto.getPassword().getBytes());

        // 保存数据
        AdminUser adminUser = new AdminUser();
        BeanUtils.copyProperties(dto, adminUser);
        adminUser.setPassword(md5Password);
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
     *
     * @param dto 用户信息更新
     */
    @Override
    public void updateAdminUser(AdminUserUpdateDto dto) {
        // 部门Id
        Long deptId = dto.getDeptId();
        Long userId = dto.getId();

        // 判断更新内容是否存在
        List<AdminUser> adminUserList = list(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));
        if (adminUserList.isEmpty()) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);

        // 更新用户
        AdminUser adminUser = new AdminUser();
        BeanUtils.copyProperties(dto, adminUser);
        updateById(adminUser);

        // 更新用户部门
        UserDept userDept = new UserDept();
        userDept.setDeptId(deptId);
        userDept.setUserId(userId);

        // 删除这个用户部门关系下所有
        userDeptMapper.deleteBatchIdsByUserIdWithPhysics(List.of(userId));

        // 插入分配后的用户内容
        userDeptMapper.insert(userDept);
    }

    /**
     * 删除|批量删除用户信息
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteAdminUser(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 逻辑删除
        baseMapper.deleteBatchIds(ids);

        // 物理删除用户
        // baseMapper.deleteBatchIdsWithPhysics(ids);

        // 删除部门相关
        userDeptMapper.deleteBatchIdsByUserIdWithPhysics(ids);

        // 删除用户角色相关
        userRoleMapper.deleteBatchIdsByUserIdsWithPhysics(ids);
    }
}
