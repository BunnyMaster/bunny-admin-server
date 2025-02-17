package cn.bunny.services.utils.login;

import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 登录策略
 */
public interface LoginStrategy {

    /**
     * 登录鉴定方法
     *
     * @param response 返回的响应
     * @param loginDto 登录参数
     * @return 鉴定身份验证
     */
    AdminUser authenticate(HttpServletResponse response, LoginDto loginDto);
}
