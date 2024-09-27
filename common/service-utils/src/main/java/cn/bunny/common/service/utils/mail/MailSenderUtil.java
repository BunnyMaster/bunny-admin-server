package cn.bunny.common.service.utils.mail;

import cn.bunny.dao.pojo.common.EmailSend;
import cn.bunny.dao.pojo.common.EmailSendInit;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Objects;

public class MailSenderUtil {
    private final String username;
    private final JavaMailSenderImpl javaMailSender;

    public MailSenderUtil(EmailSendInit emailSendInit) {
        JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
        javaMailSender.setHost(emailSendInit.getHost());
        javaMailSender.setPort(emailSendInit.getPort());
        javaMailSender.setUsername(emailSendInit.getUsername());
        javaMailSender.setPassword(emailSendInit.getPassword());
        javaMailSender.setProtocol("smtps");
        javaMailSender.setDefaultEncoding("UTF-8");

        this.username = emailSendInit.getUsername();
        this.javaMailSender = javaMailSender;
    }

    public void sendEmail(EmailSend emailSend) throws MessagingException {
        check(emailSend);

        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setFrom(username);
        helper.setTo(emailSend.getSendTo());
        helper.setSubject(emailSend.getSubject());
        helper.setText(emailSend.getMessage(), emailSend.isRichText());

        List<String> ccList = emailSend.getCcParam() != null ? List.of(emailSend.getCcParam().split(",")) : List.of();
        helper.setCc(ccList.toArray(new String[0]));

        MultipartFile[] files = emailSend.getFiles();
        if (files != null) {
            for (MultipartFile file : files) {
                helper.addAttachment(Objects.requireNonNull(file.getOriginalFilename()), file);
            }
        }

        javaMailSender.send(message);
    }

    private void check(EmailSend emailSend) {
        // 添加验证逻辑
    }
}
