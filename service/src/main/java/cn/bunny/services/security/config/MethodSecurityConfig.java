package cn.bunny.services.security.config;

import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.mapper.system.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class MethodSecurityConfig {
    
    /**
     * 设置密码校验器
     *
     * @return PasswordEncoder
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 使用数据库方式
     * 登录方式：邮箱+用户名
     *
     * @param userMapper 获取用户数据
     * @return 数据库的用户
     */
    @Bean
    public UserDetailsService userDetailsService(UserMapper userMapper) {
        return username -> {
            // 查询用户相关内容
            LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<AdminUser>()
                    .eq(AdminUser::getEmail, username)
                    .or()
                    .eq(AdminUser::getUsername, username);

            // 根据邮箱查询用户名
            AdminUser adminUser = userMapper.selectOne(queryWrapper);
            if (adminUser == null) throw new UsernameNotFoundException(ResultCodeEnum.USER_IS_EMPTY.getMessage());

            return adminUser;
        };
    }
}