package cn.bunny.services.service.system;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.system.system.dto.user.AdminUserAddDto;
import cn.bunny.services.domain.system.system.dto.user.AdminUserDto;
import cn.bunny.services.domain.system.system.dto.user.AdminUserUpdateDto;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.vo.user.AdminUserVo;
import cn.bunny.services.domain.system.system.vo.user.UserVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

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
     * 查询缓存中已登录用户
     *
     * @param pageParams 分页查询
     * @return 分页查询结果
     */
    PageResult<UserVo> getCacheUserPage(Page<AdminUser> pageParams);
}
