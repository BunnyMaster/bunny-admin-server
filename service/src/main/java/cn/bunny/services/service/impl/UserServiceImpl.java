package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.minio.MinioUtil;
import cn.bunny.dao.dto.system.user.AdminUserAddDto;
import cn.bunny.dao.dto.system.user.AdminUserDto;
import cn.bunny.dao.dto.system.user.AdminUserUpdateDto;
import cn.bunny.dao.dto.system.user.RefreshTokenDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.pojo.common.EmailSendInit;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.AdminUserVo;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.dao.vo.system.user.RefreshTokenVo;
import cn.bunny.dao.vo.system.user.UserVo;
import cn.bunny.services.factory.EmailFactory;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.EmailUsersMapper;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.service.UserService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

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
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private EmailUsersMapper emailUsersMapper;

    @Autowired
    private EmailFactory emailFactory;
    @Autowired
    private MinioUtil minioUtil;

    /**
     * 登录发送邮件验证码
     *
     * @param email 邮箱
     */
    @Override
    public void sendLoginEmail(@NotNull String email) {
        EmailUsers emailUsers = emailUsersMapper.selectOne(Wrappers.<EmailUsers>lambdaQuery().eq(EmailUsers::getIsDefault, true));
        if (emailUsers == null) throw new BunnyException(ResultCodeEnum.EMAIL_USER_TEMPLATE_IS_EMPTY);

        EmailSendInit emailSendInit = new EmailSendInit();
        BeanUtils.copyProperties(emailUsers, emailSendInit);
        emailSendInit.setUsername(emailUsers.getEmail());

        String emailCode = emailFactory.sendmailCode(email, emailSendInit);

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
        if (id == null) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);
        AdminUser user = getById(id);

        if (user == null) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);

        String avatar = user.getAvatar();

        UserVo userVo = new UserVo();
        BeanUtils.copyProperties(user, userVo);

        if (StringUtils.hasText(avatar)) userVo.setAvatar(minioUtil.getObjectNameFullPath(avatar));
        return userVo;
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
        IPage<AdminUser> page = baseMapper.selectListByPage(pageParams, dto);

        List<AdminUserVo> voList = page.getRecords().stream().map(AdminUser -> {
            AdminUserVo AdminUserVo = new AdminUserVo();
            BeanUtils.copyProperties(AdminUser, AdminUserVo);
            return AdminUserVo;
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
        // 保存数据
        AdminUser adminUser = new AdminUser();
        BeanUtils.copyProperties(dto, adminUser);
        save(adminUser);
    }

    /**
     * 更新用户信息
     *
     * @param dto 用户信息更新
     */
    @Override
    public void updateAdminUser(@Valid AdminUserUpdateDto dto) {
        // 更新内容
        AdminUser adminUser = new AdminUser();
        BeanUtils.copyProperties(dto, adminUser);
        updateById(adminUser);
    }

    /**
     * 删除|批量删除用户信息
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteAdminUser(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
