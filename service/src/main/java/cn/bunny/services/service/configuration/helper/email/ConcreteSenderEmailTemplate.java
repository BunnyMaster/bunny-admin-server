package cn.bunny.services.service.configuration.helper.email;

import cn.bunny.services.domain.system.email.entity.EmailTemplate;
import cn.bunny.services.mapper.configuration.EmailTemplateMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Component
public class ConcreteSenderEmailTemplate extends AbstractSenderEmailTemplate {

    @Resource
    private EmailTemplateMapper emailTemplateMapper;

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

    /**
     * 根据模板发送邮件
     *
     * @param email         邮件
     * @param emailTemplate 模板
     * @param params        替换参数
     */
    public void sendEmailTemplate(String email, EmailTemplate emailTemplate, HashMap<String, Object> params) {
        sendEmail(email, emailTemplate, params);
    }

    /**
     * 查询条件发送邮件
     *
     * @param email              邮件
     * @param lambdaQueryWrapper 查询条件
     * @param params             替换参数
     */
    public void sendEmailTemplate(String email, LambdaQueryWrapper<EmailTemplate> lambdaQueryWrapper, HashMap<String, Object> params) {
        EmailTemplate emailTemplate = emailTemplateMapper.selectOne(lambdaQueryWrapper);
        sendEmail(email, emailTemplate, params);
    }
}
