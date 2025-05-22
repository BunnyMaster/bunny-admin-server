package cn.bunny.services.service.configuration;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.configuration.dto.EmailUsersDto;
import cn.bunny.services.domain.configuration.entity.EmailUsers;
import cn.bunny.services.domain.configuration.vo.EmailUsersVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;
import java.util.Map;

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
     * 获取邮箱用户发送配置列表
     *
     * @return 邮箱用户发送配置返回列表
     */
    PageResult<EmailUsersVo> getEmailUserPage(Page<EmailUsers> pageParams, EmailUsersDto dto);

    /**
     * 添加邮箱用户发送配置
     *
     * @param dto 添加表单
     */
    void createEmailUsers(@Valid EmailUsersDto dto);

    /**
     * 更新邮箱用户发送配置
     *
     * @param dto 更新表单
     */
    void updateEmailUsers(@Valid EmailUsersDto dto);

    /**
     * 删除|批量删除邮箱用户发送配置类型
     *
     * @param ids 删除id列表
     */
    void deleteEmailUsers(List<Long> ids);

    /**
     * 获取所有邮箱配置用户
     *
     * @return 邮件用户列表
     */
    List<Map<String, String>> getAllMailboxConfigurationUsers();

}
