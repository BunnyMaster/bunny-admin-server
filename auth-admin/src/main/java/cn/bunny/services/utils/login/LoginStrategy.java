package cn.bunny.services.utils.login;


import cn.bunny.domain.system.dto.user.LoginDto;
import cn.bunny.domain.system.entity.AdminUser;

/**
 * 登录策略
 */
public interface LoginStrategy {

    /**
     * 登录鉴定方法
     *
     * @param loginDto 登录参数
     * @return 鉴定身份验证
     */
    AdminUser authenticate(LoginDto loginDto);
}
