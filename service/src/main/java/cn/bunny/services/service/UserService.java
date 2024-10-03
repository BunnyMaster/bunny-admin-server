package cn.bunny.services.service;

import cn.bunny.dao.dto.system.user.AdminUserAddDto;
import cn.bunny.dao.dto.system.user.AdminUserDto;
import cn.bunny.dao.dto.system.user.AdminUserUpdateDto;
import cn.bunny.dao.dto.system.user.RefreshTokenDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.user.AdminUserVo;
import cn.bunny.dao.vo.system.user.RefreshTokenVo;
import cn.bunny.dao.vo.system.user.UserVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;
import org.jetbrains.annotations.NotNull;

import java.util.List;

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
     * * 获取用户信息列表
     *
     * @return 用户信息返回列表
     */
    PageResult<AdminUserVo> getAdminUserList(Page<AdminUser> pageParams, AdminUserDto dto);

    /**
     * * 添加用户信息
     *
     * @param dto 添加表单
     */
    void addAdminUser(@Valid AdminUserAddDto dto);

    /**
     * * 更新用户信息
     *
     * @param dto 更新表单
     */
    void updateAdminUser(@Valid AdminUserUpdateDto dto);

    /**
     * * 删除|批量删除用户信息类型
     *
     * @param ids 删除id列表
     */
    void deleteAdminUser(List<Long> ids);

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

    /**
     * * 获取用户信息
     *
     * @param id 用户id
     * @return 用户信息
     */
    UserVo getUserinfoById(Long id);
}
