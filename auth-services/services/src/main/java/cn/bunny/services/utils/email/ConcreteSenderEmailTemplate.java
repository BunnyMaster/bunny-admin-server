package cn.bunny.services.utils.email;

import cn.bunny.domain.email.entity.EmailTemplate;
import cn.bunny.services.mapper.configuration.EmailTemplateMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
public class ConcreteSenderEmailTemplate extends AbstractSenderEmailTemplate {
    private final EmailTemplateMapper emailTemplateMapper;

    public ConcreteSenderEmailTemplate(EmailTemplateMapper emailTemplateMapper) {
        this.emailTemplateMapper = emailTemplateMapper;
    }

    /**
     * 发送邮件模板
     * 根据邮件模板发送邮件
     *
     * @param email           邮件
     * @param emailTemplateId 模板Id
     * @param params          替换参数
     */
    public void sendEmailTemplate(String email, Long emailTemplateId, HashMap<String, Object> params) {
        EmailTemplate emailTemplate = emailTemplateMapper.selectOne(Wrappers.<EmailTemplate>lambdaQuery().eq(EmailTemplate::getId, emailTemplateId));
        sendEmail(email, emailTemplate, params);
    }
}
