package cn.bunny.services.utils.login;

import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.services.mapper.system.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

/**
 * 使用用户名登录
 */
public class DefaultLoginStrategy implements LoginStrategy {
    private final UserMapper userMapper;

    public DefaultLoginStrategy(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    /**
     * 登录鉴定方法
     * 默认登录方式，使用用户名查询用户
     *
     * @param loginDto 登录参数
     * @return 鉴定身份验证
     */
    @Override
    public AdminUser authenticate(LoginDto loginDto) {
        String username = loginDto.getUsername();

        // 查询用户相关内容
        LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AdminUser::getUsername, username);
        return userMapper.selectOne(queryWrapper);
    }
}