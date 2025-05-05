package cn.bunny.services.service.configuration.helper.email;

import cn.bunny.services.config.mail.MailSenderConfiguration;
import cn.bunny.services.domain.common.model.dto.email.EmailSend;
import cn.bunny.services.domain.common.model.dto.email.EmailSendInit;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.system.email.entity.EmailTemplate;
import cn.bunny.services.domain.system.email.entity.EmailUsers;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.configuration.EmailUsersMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import jakarta.mail.MessagingException;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashMap;
import java.util.List;

public abstract class AbstractSenderEmailTemplate {

    @Autowired
    private EmailUsersMapper emailUsersMapper;

    /**
     * 基本邮件发送模板
     *
     * @param email         邮箱
     * @param emailTemplate 邮箱模板
     * @param params        传入的参数
     */
    public void sendEmail(String email, EmailTemplate emailTemplate, HashMap<String, Object> params) {
        // 判断邮件模板是否为空
        if (emailTemplate == null) throw new AuthCustomerException(ResultCodeEnum.EMAIL_TEMPLATE_IS_EMPTY);

        // 查询配置发送邮箱，如果没有配置发件者邮箱改用用户列表中默认的，如果默认的也为空则报错
        Long emailUser = emailTemplate.getEmailUser();
        EmailUsers emailUsers;
        if (emailUser == null) {
            // 如果用户不存在就是用默认用户进行邮件发送
            emailUsers = emailUsersMapper.selectOne(Wrappers.<EmailUsers>lambdaQuery().eq(EmailUsers::getIsDefault, true));

            // 默认发送用户也不存在
            if (emailUsers == null) throw new AuthCustomerException(ResultCodeEnum.EMAIL_USER_IS_EMPTY);
        } else {
            emailUsers = emailUsersMapper.selectOne(Wrappers.<EmailUsers>lambdaQuery().eq(EmailUsers::getId, emailUser));
        }

        // 查询发件者信息
        EmailSendInit emailSendInit = new EmailSendInit();
        BeanUtils.copyProperties(emailUsers, emailSendInit);
        emailSendInit.setUsername(emailUsers.getEmail());
        emailSendInit.setProtocol(emailUsers.getSmtpAgreement());

        // 邮件发送模板
        EmailSend emailSend = new EmailSend();
        emailSend.setSubject(emailTemplate.getSubject());
        emailSend.setSendTo(List.of(email));
        emailSend.setRichText(true);

        // 替换模板中字符串
        final String[] modifiedTemplate = {emailTemplate.getBody()};
        params.forEach((key, value) -> modifiedTemplate[0] = modifiedTemplate[0].replaceAll(key, String.valueOf(value)));

        // 发送邮件
        try {
            emailSend.setText(modifiedTemplate[0]);
            MailSenderConfiguration.sendEmail(emailSendInit, emailSend);
        } catch (MessagingException e) {
            throw new AuthCustomerException(ResultCodeEnum.SEND_MAIL_CODE_ERROR);
        }
    }
}