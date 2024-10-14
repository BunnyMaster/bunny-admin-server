package cn.bunny.services.service;

import cn.bunny.dao.dto.system.email.EmailTemplateAddDto;
import cn.bunny.dao.dto.system.email.EmailTemplateDto;
import cn.bunny.dao.dto.system.email.EmailTemplateUpdateDto;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.email.EmailTemplateVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 邮件模板表 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 21:24:08
 */
public interface EmailTemplateService extends IService<EmailTemplate> {

    /**
     * * 获取邮件模板表列表
     *
     * @return 邮件模板表返回列表
     */
    PageResult<EmailTemplateVo> getEmailTemplateList(Page<EmailTemplate> pageParams, EmailTemplateDto dto);

    /**
     * * 添加邮件模板表
     *
     * @param dto 添加表单
     */
    void addEmailTemplate(@Valid EmailTemplateAddDto dto);

    /**
     * * 更新邮件模板表
     *
     * @param dto 更新表单
     */
    void updateEmailTemplate(@Valid EmailTemplateUpdateDto dto);

    /**
     * * 删除|批量删除邮件模板表类型
     *
     * @param ids 删除id列表
     */
    void deleteEmailTemplate(List<Long> ids);
}
