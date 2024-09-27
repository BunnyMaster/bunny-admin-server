package cn.bunny.services.service;

import cn.bunny.dao.dto.user.RefreshTokenDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.vo.user.RefreshTokenVo;
import com.baomidou.mybatisplus.extension.service.IService;
import org.jetbrains.annotations.NotNull;

/**
 * <p>
 * 用户信息 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
public interface UserService extends IService<AdminUser> {

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
