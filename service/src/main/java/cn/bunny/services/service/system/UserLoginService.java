package cn.bunny.services.service.system;

import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.system.system.dto.user.LoginDto;
import cn.bunny.services.domain.system.system.dto.user.RefreshTokenDto;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.vo.user.RefreshTokenVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jetbrains.annotations.NotNull;

public interface UserLoginService extends IService<AdminUser> {

    /**
     * 前台用户登录接口
     *
     * @param loginDto 登录参数
     * @return 登录后结果返回
     */
    LoginVo login(LoginDto loginDto);

    /**
     * 登录发送邮件验证码
     *
     * @param email 邮箱
     */
    void sendLoginEmail(@NotNull String email);

    /**
     * 刷新用户token
     *
     * @param dto 请求token
     * @return 刷新token返回内容
     */
    @NotNull
    RefreshTokenVo refreshToken(@NotNull RefreshTokenDto dto);

    /**
     * * 退出登录
     */
    void logout();

}
