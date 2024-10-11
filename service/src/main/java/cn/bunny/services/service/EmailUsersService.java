package cn.bunny.services.service;

import cn.bunny.dao.dto.system.email.EmailUserUpdateStatusDto;
import cn.bunny.dao.dto.system.email.EmailUsersAddDto;
import cn.bunny.dao.dto.system.email.EmailUsersDto;
import cn.bunny.dao.dto.system.email.EmailUsersUpdateDto;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.email.EmailUsersVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 邮箱用户发送配置 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 15:19:22
 */
public interface EmailUsersService extends IService<EmailUsers> {

    /**
     * * 获取邮箱用户发送配置列表
     *
     * @return 邮箱用户发送配置返回列表
     */
    PageResult<EmailUsersVo> getEmailUsersList(Page<EmailUsers> pageParams, EmailUsersDto dto);

    /**
     * * 添加邮箱用户发送配置
     *
     * @param dto 添加表单
     */
    void addEmailUsers(@Valid EmailUsersAddDto dto);

    /**
     * * 更新邮箱用户发送配置
     *
     * @param dto 更新表单
     */
    void updateEmailUsers(@Valid EmailUsersUpdateDto dto);

    /**
     * * 删除|批量删除邮箱用户发送配置类型
     *
     * @param ids 删除id列表
     */
    void deleteEmailUsers(List<Long> ids);

    /**
     * * 更新邮箱用户状态
     *
     * @param dto 邮箱用户更新状态表单
     */
    void updateEmailUserStatus(EmailUserUpdateStatusDto dto);
}
