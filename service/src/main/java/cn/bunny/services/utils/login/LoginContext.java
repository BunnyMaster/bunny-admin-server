package cn.bunny.services.utils.login;

import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Map;

/**
 * 登录策略上下文
 */
public class LoginContext {
    private final Map<String, LoginStrategy> strategies;

    public LoginContext(Map<String, LoginStrategy> strategies) {
        this.strategies = strategies;
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