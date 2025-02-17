package cn.bunny.services.utils.login;

import cn.bunny.common.service.utils.ResponseUtil;
import cn.bunny.dao.constant.RedisUserConstant;
import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.mapper.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.data.redis.core.RedisTemplate;

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
     *
     * @param response 返回的响应
     * @param loginDto 登录参数
     * @return 鉴定身份验证
     */
    @Override
    public AdminUser authenticate(HttpServletResponse response, LoginDto loginDto) {
        String username = loginDto.getUsername();
        String emailCode = loginDto.getEmailCode().toLowerCase();

        Object redisEmailCode = redisTemplate.opsForValue().get(RedisUserConstant.getAdminUserEmailCodePrefix(username));
        if (redisEmailCode == null) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.EMAIL_CODE_EMPTY));
            return null;
        }

        // 判断用户邮箱验证码是否和Redis中发送的验证码
        if (!emailCode.equals(redisEmailCode.toString().toLowerCase())) {
            ResponseUtil.out(response, Result.error(ResultCodeEnum.EMAIL_CODE_NOT_MATCHING));
            return null;
        }

        // 查询用户相关内容
        LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AdminUser::getEmail, username);
        return userMapper.selectOne(queryWrapper);
    }
}
