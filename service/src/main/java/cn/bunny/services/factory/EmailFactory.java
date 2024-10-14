package cn.bunny.services.factory;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.mail.MailSenderUtil;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.pojo.common.EmailSend;
import cn.bunny.dao.pojo.common.EmailSendInit;
import cn.bunny.dao.pojo.common.EmailTemplateTypes;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.services.mapper.EmailTemplateMapper;
import cn.bunny.services.mapper.EmailUsersMapper;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import jakarta.mail.MessagingException;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EmailFactory {

    @Autowired
    private EmailTemplateMapper emailTemplateMapper;

    @Autowired
    private EmailUsersMapper emailUsersMapper;

    /**
     * 生成邮箱验证码
     *
     * @param email 接受者邮箱
     */
    public String sendmailCode(String email) {
        // 查询验证码邮件模板
        LambdaQueryWrapper<EmailTemplate> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(EmailTemplate::getIsDefault, true);
        lambdaQueryWrapper.eq(EmailTemplate::getType, EmailTemplateTypes.VERIFICATION_CODE.getType());
        EmailTemplate emailTemplate = emailTemplateMapper.selectOne(lambdaQueryWrapper);

        // 判断邮件模板是否为空
        if (emailTemplate == null) throw new BunnyException(ResultCodeEnum.EMAIL_TEMPLATE_IS_EMPTY);

        // 查询配置发送邮箱
        Long emailUser = emailTemplate.getEmailUser();
        EmailUsers emailUsers;
        // 如果没有配置发件者邮箱改用用户列表中默认的
        if (emailUser == null) {
            emailUsers = emailUsersMapper.selectOne(Wrappers.<EmailUsers>lambdaQuery().eq(EmailUsers::getIsDefault, true));
            // 如果默认的也为空则报错
            if (emailUsers == null) throw new BunnyException(ResultCodeEnum.EMAIL_USER_IS_EMPTY);
        } else {
            emailUsers = emailUsersMapper.selectOne(Wrappers.<EmailUsers>lambdaQuery().eq(EmailUsers::getId, emailUser));
        }

        // 查询发件者信息
        EmailSendInit emailSendInit = new EmailSendInit();
        BeanUtils.copyProperties(emailUsers, emailSendInit);
        emailSendInit.setUsername(emailUsers.getEmail());

        // 生成验证码
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(150, 48, 4, 2);
        String code = captcha.getCode();
        String htmlContent = emailTemplate.getBody()
                .replace("${sendEmailUser}", emailUsers.getEmail())
                .replace("${verifyCode}", code);

        // 发送验证码
        MailSenderUtil mailSenderUtil = new MailSenderUtil(emailSendInit);
        try {
            EmailSend emailSend = new EmailSend();
            emailSend.setSubject(emailTemplate.getSubject());
            emailSend.setMessage(htmlContent);
            emailSend.setSendTo(email);
            emailSend.setRichText(true);
            mailSenderUtil.sendEmail(emailSend);
        } catch (MessagingException e) {
            throw new BunnyException(ResultCodeEnum.SEND_MAIL_CODE_ERROR);
        }

        return code;
    }

    /**
     * 判断邮箱是否添加
     *
     * @param isDefault 邮箱是否为默认
     */
    public void updateEmailUserDefault(Boolean isDefault) {
        EmailUsers emailUsers = new EmailUsers();
        // 判断状态，如果是默认将所有的内容都设为false
        if (isDefault) {
            emailUsers.setIsDefault(false);
            emailUsersMapper.update(emailUsers, Wrappers.<EmailUsers>lambdaUpdate().eq(EmailUsers::getIsDefault, true));
        }
    }
}