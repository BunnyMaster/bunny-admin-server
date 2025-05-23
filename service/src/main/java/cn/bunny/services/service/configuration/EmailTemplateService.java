package cn.bunny.services.service.configuration;

import cn.bunny.services.domain.system.email.dto.EmailTemplateAddDto;
import cn.bunny.services.domain.system.email.dto.EmailTemplateDto;
import cn.bunny.services.domain.system.email.dto.EmailTemplateUpdateDto;
import cn.bunny.services.domain.system.email.entity.EmailTemplate;
import cn.bunny.services.domain.system.email.vo.EmailTemplateVo;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

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
    void addEmailTemplate(@Valid EmailTemplateAddDto dto);

    /**
     * 更新邮件模板表
     *
     * @param dto 更新表单
     */
    void updateEmailTemplate(@Valid EmailTemplateUpdateDto dto);

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
