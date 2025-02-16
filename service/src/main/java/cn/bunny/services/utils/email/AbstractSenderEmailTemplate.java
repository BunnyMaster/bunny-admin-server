package cn.bunny.services.utils.email;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.common.service.utils.mail.MailSenderUtil;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.model.email.EmailSend;
import cn.bunny.dao.model.email.EmailSendInit;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.mapper.EmailUsersMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import jakarta.mail.MessagingException;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;

@Component
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
            emailUsers = emailUsersMapper.selectOne(Wrappers.<EmailUsers>lambdaQuery().eq(EmailUsers::getIsDefault, true));
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
            MailSenderUtil.sendEmail(emailSendInit, emailSend);
        } catch (MessagingException e) {
            throw new AuthCustomerException(ResultCodeEnum.SEND_MAIL_CODE_ERROR);
        }
    }
}