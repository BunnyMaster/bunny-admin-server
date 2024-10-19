package cn.bunny.common.service.utils.mail;

import cn.bunny.dao.pojo.common.EmailSend;
import cn.bunny.dao.pojo.common.EmailSendInit;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.multipart.MultipartFile;

import java.util.Objects;

public class MailSenderUtil {

    /**
     * * 邮件发送初始化
     *
     * @param emailSendInit 邮件发送初始化
     */
    public static JavaMailSenderImpl senderUtil(EmailSendInit emailSendInit) {
        JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
        javaMailSender.setHost(emailSendInit.getHost());
        javaMailSender.setPort(emailSendInit.getPort());
        javaMailSender.setUsername(emailSendInit.getUsername());
        javaMailSender.setPassword(emailSendInit.getPassword());
        javaMailSender.setProtocol(emailSendInit.getProtocol());
        javaMailSender.setDefaultEncoding("UTF-8");

        return javaMailSender;
    }

    /**
     * * 发送邮件
     *
     * @param emailSendInit 邮件发送初始化
     * @param emailSend     邮件发送表单
     */
    public static void sendEmail(EmailSendInit emailSendInit, EmailSend emailSend) throws MessagingException {
        // 发送邮件初始化
        JavaMailSenderImpl javaMailSender = senderUtil(emailSendInit);
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        // 设置发件人
        helper.setFrom(emailSendInit.getUsername());

        // 设置群发内容
        helper.setTo(emailSend.getSendTo().toArray(new String[0]));

        // 设置主题
        helper.setSubject(emailSend.getSubject());

        // 设置发送文本
        helper.setText(emailSend.getText(), emailSend.isRichText());

        // 设置抄送
        helper.setCc(emailSend.getCcParam().toArray(new String[0]));

        // 设置附件
        MultipartFile[] files = emailSend.getFiles();
        if (files != null) {
            for (MultipartFile file : files) {
                helper.addAttachment(Objects.requireNonNull(file.getOriginalFilename()), file);
            }
        }

        // 发送邮件
        javaMailSender.send(message);
    }
}
