package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.dao.dto.user.RefreshTokenDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.pojo.common.EmailSendInit;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.user.LoginVo;
import cn.bunny.dao.vo.user.RefreshTokenVo;
import cn.bunny.services.factory.EmailFactory;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.EmailUsersMapper;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.service.UserService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


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
    public RefreshTokenVo refreshToken(RefreshTokenDto dto) {
        Long userId = JwtHelper.getUserId(dto.getRefreshToken());
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));

        if (adminUser == null) throw new BunnyException(ResultCodeEnum.FAIL_REQUEST_NOT_AUTH);
        if (adminUser.getStatus() == 1) throw new BunnyException(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED);

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
}
