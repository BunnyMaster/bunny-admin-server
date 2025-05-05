package cn.bunny.services.service.system.helper.login;

import cn.bunny.services.domain.common.constant.RedisUserConstant;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.system.system.dto.user.LoginDto;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.mapper.system.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 * 邮箱登录策略
 */
public class EmailLoginStrategy implements LoginStrategy {
    private final RedisTemplate<String, Object> redisTemplate;
    private final UserMapper userMapper;

    public EmailLoginStrategy(RedisTemplate<String, Object> redisTemplate, UserMapper userMapper) {
        this.redisTemplate = redisTemplate;
        this.userMapper = userMapper;
    }

    /**
     * 登录鉴定方法
     * 只要判断邮箱验证码是否相等，在前面已经验证过用户密码
     * <p>
     * 抛出异常类型 UsernameNotFoundException 如果要自定义状态码需要使用 HttpServletResponse
     * 有封装好的 ResponseUtil.out() 方法
     * </p>
     *
     * @param loginDto 登录参数
     * @return 鉴定身份验证
     */
    @Override
    public AdminUser authenticate(LoginDto loginDto) {
        String username = loginDto.getUsername();
        String emailCode = loginDto.getEmailCode().toLowerCase();

        // 查找Redis中的验证码
        Object redisEmailCode = redisTemplate.opsForValue().get(RedisUserConstant.getAdminUserEmailCodePrefix(username));
        if (redisEmailCode == null) {
            throw new UsernameNotFoundException(ResultCodeEnum.EMAIL_CODE_EMPTY.getMessage());
        }

        // 判断用户邮箱验证码是否和Redis中发送的验证码
        if (!emailCode.equals(redisEmailCode.toString().toLowerCase())) {
            throw new UsernameNotFoundException(ResultCodeEnum.EMAIL_CODE_NOT_MATCHING.getMessage());
        }

        // 查询用户相关内容
        LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AdminUser::getEmail, username);
        return userMapper.selectOne(queryWrapper);
    }

    /**
     * 登录完成后的内容
     *
     * @param loginDto  登录参数
     * @param adminUser 用户
     */
    @Override
    public void authenticateAfter(LoginDto loginDto, AdminUser adminUser) {
        // 将Redis中验证码删除
        String emailCodePrefix = RedisUserConstant.getAdminUserEmailCodePrefix(loginDto.getUsername());
        redisTemplate.delete(emailCodePrefix);
    }

}
