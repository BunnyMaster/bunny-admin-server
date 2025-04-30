package cn.bunny.services.utils.login;

import cn.bunny.services.domain.system.system.dto.user.LoginDto;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Map;

/**
 * 登录策略上下文
 */
public class LoginContext {

    private final Map<String, LoginStrategy> strategies;
    private final PasswordEncoder passwordEncoder;

    public LoginContext(Map<String, LoginStrategy> strategies, PasswordEncoder passwordEncoder) {
        this.strategies = strategies;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * 执行登录策略
     * 根据情况判断 type 是否为空
     *
     * @param loginDto 登录参数
     * @return 用户
     */
    public AdminUser executeStrategy(LoginDto loginDto) {
        String type = loginDto.getType();
        LoginStrategy strategy = strategies.get(type);

        if (strategy == null) {
            throw new UsernameNotFoundException("不支持登录类型: " + type);
        }

        return strategy.authenticate(loginDto);
    }
}