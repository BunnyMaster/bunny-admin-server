package cn.bunny.services.utils.mail;

import cn.bunny.dao.model.email.EmailSend;
import cn.bunny.dao.model.email.EmailSendInit;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.jetbrains.annotations.NotNull;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.multipart.MultipartFile;

import java.util.Objects;
import java.util.Properties;

public class MailSenderUtil {
    private MailSenderUtil() {
        // 私有化构造器
    }

    /**
     * 如果启用SSL需要配置以下
     *
     * @param emailSendInit 邮件发送初始化
     */
    private static @NotNull Properties getProperties(EmailSendInit emailSendInit) {
        Properties properties = new Properties();
        // 开启认证
        properties.setProperty("mail.smtp.auth", "true");
        // 是否启用调试---会输出发送邮件调试内容
        properties.setProperty("mail.debug", "false");
        // 设置链接超时
        properties.setProperty("mail.smtp.timeout", "200000");
        // 设置端口
        properties.setProperty("mail.smtp.port", Integer.toString(25));
        // 设置ssl端口
        properties.setProperty("mail.smtp.socketFactory.port", Integer.toString(emailSendInit.getPort()));
        properties.setProperty("mail.smtp.socketFactory.fallback", "false");
        properties.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        return properties;
    }

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

        // 如果开启SSL
        if (emailSendInit.getOpenSSL()) {
            Properties properties = getProperties(emailSendInit);
            javaMailSender.setJavaMailProperties(properties);
        }

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
