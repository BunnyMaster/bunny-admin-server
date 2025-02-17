package cn.bunny.services.utils.login;

import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Map;

/**
 * 登录策略上下文
 */
public class LoginContext {
    private final Map<String, LoginStrategy> strategies;

    public LoginContext(Map<String, LoginStrategy> strategies) {
        this.strategies = strategies;
    }

    public AdminUser executeStrategy(String type, LoginDto loginDto, HttpServletResponse response) {
        LoginStrategy strategy = strategies.get(type);
        if (strategy == null) {
            throw new IllegalArgumentException("不支持登录类型: " + type);
        }
        return strategy.authenticate(response, loginDto);
    }
}