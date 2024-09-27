package cn.bunny.services.factory;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.common.service.utils.mail.MailSenderUtil;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.pojo.common.EmailSend;
import cn.bunny.dao.pojo.common.EmailSendInit;
import cn.bunny.dao.pojo.common.EmailTemplateTypes;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.services.mapper.EmailTemplateMapper;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class EmailFactory {
    @Autowired
    private EmailTemplateMapper emailTemplateMapper;

    /**
     * 生成邮箱验证码
     *
     * @param email         接受者邮箱
     * @param emailSendInit 初始化发送参数
     */
    public String sendmailCode(String email, EmailSendInit emailSendInit) {
        // 查询验证码邮件模板
        LambdaQueryWrapper<EmailTemplate> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(EmailTemplate::getIsDefault, true);
        lambdaQueryWrapper.eq(EmailTemplate::getType, EmailTemplateTypes.VERIFICATION_CODE.getType());
        EmailTemplate emailTemplate = emailTemplateMapper.selectOne(lambdaQueryWrapper);

        // 判断邮件模板是否为空
        if (emailTemplate == null) {
            throw new BunnyException(ResultCodeEnum.EMAIL_TEMPLATE_IS_EMPTY);
        }

        // 生成验证码
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(150, 48, 4, 2);
        String code = captcha.getCode();
        String htmlContent = emailTemplate.getBody().replace("${verifyCode}", code);

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
}