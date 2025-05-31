package cn.bunny.services.service.configuration;

import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.model.configuration.dto.EmailTemplateDto;
import cn.bunny.domain.model.configuration.entity.EmailTemplate;
import cn.bunny.domain.model.configuration.vo.EmailTemplateVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

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
     * 获取邮件模板表列表
     *
     * @return 邮件模板表返回列表
     */
    PageResult<EmailTemplateVo> getEmailTemplatePage(Page<EmailTemplate> pageParams, EmailTemplateDto dto);

    /**
     * 添加邮件模板表
     *
     * @param dto 添加表单
     */
    void createEmailTemplate(EmailTemplateDto dto);

    /**
     * 更新邮件模板表
     *
     * @param dto 更新表单
     */
    void updateEmailTemplate(EmailTemplateDto dto);

    /**
     * 删除|批量删除邮件模板表类型
     *
     * @param ids 删除id列表
     */
    void deleteEmailTemplate(List<Long> ids);

    /**
     * 获取模板类型字段
     *
     * @return 枚举字段列表
     */
    List<Map<String, String>> getEmailTypeList();
}
