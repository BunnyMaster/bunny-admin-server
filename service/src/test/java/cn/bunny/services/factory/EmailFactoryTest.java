package cn.bunny.services.factory;

import cn.bunny.common.service.utils.mail.MailSenderUtil;
import cn.bunny.dao.pojo.common.EmailSend;
import cn.bunny.dao.pojo.common.EmailSendInit;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

class EmailFactoryTest {
    @Test
    void testSendEmail() throws Exception {
        File file = new File("H:\\学习\\WpfApp2\\WpfApp2");
        List<MultipartFile> fileList = Arrays.stream(Objects.requireNonNull(file.listFiles())).map(file1 -> {
            try {
                return (MultipartFile) new MockMultipartFile("file", file.getName(), null, new FileInputStream(file1));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }).toList();

        // 初始化发送内容
        EmailSendInit emailSendInit = new EmailSendInit();
        emailSendInit.setUsername("3324855376@qq.com");
        emailSendInit.setPassword("fdehkkbmavalcjea");
        emailSendInit.setPort(465);
        emailSendInit.setHost("smtp.qq.com");

        // 发送邮件信息
        EmailSend emailSend = new EmailSend();
        emailSend.setSendTo(List.of("794demetris@rustyload.com", "a0w_q6ct@linshiyouxiang.net"));
        emailSend.setSubject("测试邮件发送");
        emailSend.setText("<h1>测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试</h1>");
        emailSend.setRichText(true);
        emailSend.setCcParam(List.of("tiec@snapmail.cc", "yenibex934@angewy.com"));
        emailSend.setFiles(fileList.toArray(new MultipartFile[0]));

        // 发送邮件
        MailSenderUtil.sendEmail(emailSendInit, emailSend);
    }

    @Test
    void testReplace() {
        final String[] modifiedTemplate = {"template"};

        HashMap<String, Object> hashMap = new HashMap<>();
        hashMap.put("#title#", "BunnyAdmin");
        hashMap.put("#erifyCode#", "emailCode");
        hashMap.put("#expires#", 15);
        hashMap.put("#sendEmailUser#", "emailUsers.getEmail()");
        hashMap.put("#companyName#", "BunnyAdmin");

        hashMap.forEach((key, value) -> modifiedTemplate[0] = modifiedTemplate[0].replaceAll(key, String.valueOf(value)));
    }
}