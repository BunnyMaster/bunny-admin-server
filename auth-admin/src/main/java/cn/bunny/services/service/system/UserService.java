package cn.bunny.services.service.system;

import cn.bunny.domain.system.dto.user.*;
import cn.bunny.domain.system.entity.AdminUser;
import cn.bunny.domain.system.vo.user.AdminUserVo;
import cn.bunny.domain.system.vo.user.RefreshTokenVo;
import cn.bunny.domain.system.vo.user.UserVo;
import cn.bunny.domain.vo.LoginVo;
import cn.bunny.domain.vo.result.PageResult;
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
     * 前台用户登录接口
     *
     * @param loginDto 登录参数
     * @return 登录后结果返回
     */
    LoginVo login(LoginDto loginDto);

    /**
     * * 获取用户信息列表
     *
     * @return 用户信息返回列表
     */
    PageResult<AdminUserVo> getUserPageByAdmin(Page<AdminUser> pageParams, AdminUserDto dto);

    /**
     * * 添加用户信息
     *
     * @param dto 添加表单
     */
    void addUserByAdmin(@Valid AdminUserAddDto dto);

    /**
     * * 更新用户信息
     *
     * @param dto 更新表单
     */
    void updateUserByAdmin(@Valid AdminUserUpdateDto dto);

    /**
     * * 删除|批量删除用户信息类型
     *
     * @param ids 删除id列表
     */
    void deleteUserByAdmin(List<Long> ids);

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

    /**
     * * 强制退出
     *
     * @param id 用户id
     */
    void forcedOfflineByAdmin(Long id);

    /**
     * * 查询用户
     *
     * @param keyword 查询用户信息关键字
     * @return 用户信息列表
     */
    List<UserVo> getUserListByKeyword(String keyword);

    /**
     * * 更新本地用户信息
     *
     * @param dto 用户信息
     */
    void updateAdminUserByLocalUser(AdminUserUpdateByLocalUserDto dto);

    /**
     * * 更新本地用户密码
     *
     * @param password 更新本地用户密码
     */
    void updateUserPasswordByLocalUser(@Valid String password);
}
