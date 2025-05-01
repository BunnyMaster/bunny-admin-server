package cn.bunny.services.service.system.impl;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.constant.UserConstant;
import cn.bunny.services.domain.common.enums.EmailTemplateEnums;
import cn.bunny.services.domain.common.enums.LoginEnums;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.domain.system.email.entity.EmailTemplate;
import cn.bunny.services.domain.system.system.dto.user.LoginDto;
import cn.bunny.services.domain.system.system.dto.user.RefreshTokenDto;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.vo.user.RefreshTokenVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.configuration.EmailTemplateMapper;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.service.system.UserLoginService;
import cn.bunny.services.service.system.helper.UserLoginHelper;
import cn.bunny.services.service.system.helper.login.DefaultLoginStrategy;
import cn.bunny.services.service.system.helper.login.EmailLoginStrategy;
import cn.bunny.services.service.system.helper.login.LoginContext;
import cn.bunny.services.service.system.helper.login.LoginStrategy;
import cn.bunny.services.utils.IpUtil;
import cn.bunny.services.utils.JwtTokenUtil;
import cn.bunny.services.utils.email.ConcreteSenderEmailTemplate;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

@Service
public class UserLoginServiceImpl extends ServiceImpl<UserMapper, AdminUser> implements UserLoginService {
    @Resource
    private UserLoginHelper userloginHelper;
    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    @Resource
    private PasswordEncoder passwordEncoder;
    @Resource
    private UserMapper userMapper;
    @Resource
    private EmailTemplateMapper emailTemplateMapper;
    @Resource
    private ConcreteSenderEmailTemplate concreteSenderEmailTemplate;

    /**
     * 前台用户登录接口
     * 这里不用判断用户是否为空，因为在登录时已经校验过了
     * <p>
     * 抛出异常使用自带的 UsernameNotFoundException 或者自己封装<br/>
     * 但是这两个效果传入参数都是一样的，所以全部使用 UsernameNotFoundException
     * </p>
     *
     * @param loginDto 登录参数
     * @return 登录后结果返回
     */
    @Override
    public LoginVo login(LoginDto loginDto) {
        // 初始化所有策略（可扩展）
        HashMap<String, LoginStrategy> loginStrategyHashMap = new HashMap<>();
        // 默认的登录方式
        loginStrategyHashMap.put(LoginEnums.default_STRATEGY.getValue(), new DefaultLoginStrategy(userMapper));
        // 注册邮箱
        loginStrategyHashMap.put(LoginEnums.EMAIL_STRATEGY.getValue(), new EmailLoginStrategy(redisTemplate, userMapper));

        // 使用登录上下文调用登录策略
        LoginContext loginContext = new LoginContext(loginStrategyHashMap);
        AdminUser user = loginContext.executeStrategy(loginDto);

        // 验证登录逻辑
        if (user == null) throw new UsernameNotFoundException(ResultCodeEnum.USER_IS_EMPTY.getMessage());

        // 数据库密码
        String dbPassword = user.getPassword();
        String password = loginDto.getPassword();
        if (!passwordEncoder.matches(password, dbPassword)) {
            throw new UsernameNotFoundException(ResultCodeEnum.LOGIN_ERROR.getMessage());
        }

        // 判断用户是否禁用
        if (user.getStatus()) {
            throw new UsernameNotFoundException(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED.getMessage());
        }

        // 登录结束后的操作
        loginContext.loginAfter(loginDto, user);

        user.setUpdateUser(user.getId());
        user.setCreateUser(user.getId());
        return userloginHelper.buildLoginUserVo(user, loginDto.getReadMeDay());
    }

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
        concreteSenderEmailTemplate.sendEmailTemplate(email, emailTemplate, hashMap);

        // 在Redis中存储验证码
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminUserEmailCodePrefix(email), emailCode, RedisUserConstant.REDIS_EXPIRATION_TIME, TimeUnit.MINUTES);
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
        Long userId = JwtTokenUtil.getUserId(dto.getRefreshToken());
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));

        // 用户存在且没有禁用
        if (adminUser == null) throw new AuthCustomerException(ResultCodeEnum.USER_IS_EMPTY);
        if (adminUser.getStatus()) throw new AuthCustomerException(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED);

        LoginVo buildUserVo = userloginHelper.buildLoginUserVo(adminUser, dto.getReadMeDay());
        RefreshTokenVo refreshTokenVo = new RefreshTokenVo();
        BeanUtils.copyProperties(buildUserVo, refreshTokenVo);

        return refreshTokenVo;
    }

    /**
     * 退出登录
     */
    @Override
    public void logout() {
        // 获取上下文对象中的用户ID和用户token
        LoginVo loginVo = BaseContext.getLoginVo();
        String token = loginVo.getToken();
        Long userId = BaseContext.getUserId();

        // 获取IP地址
        String ipAddr = IpUtil.getCurrentUserIpAddress().getIpAddr();
        String ipRegion = IpUtil.getCurrentUserIpAddress().getIpRegion();

        // 查询用户信息
        AdminUser adminUser = getOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getId, userId));
        adminUser.setIpAddress(ipAddr);
        adminUser.setIpRegion(ipRegion);
        userloginHelper.setUserLoginLog(adminUser, token, UserConstant.LOGOUT);

        // 删除Redis中用户信息
        String loginInfoPrefix = RedisUserConstant.getAdminLoginInfoPrefix(adminUser.getUsername());
        redisTemplate.delete(loginInfoPrefix);
    }
}
