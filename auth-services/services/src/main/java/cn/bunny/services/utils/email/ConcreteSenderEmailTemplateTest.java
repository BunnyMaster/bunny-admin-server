package cn.bunny.services.utils.email;

import cn.bunny.domain.email.entity.EmailTemplate;
import cn.bunny.services.mapper.configuration.EmailTemplateMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.HashMap;

@SpringBootTest
class ConcreteSenderEmailTemplateTest extends AbstractSenderEmailTemplate {
    @Autowired
    private EmailTemplateMapper emailTemplateMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    void sendEmailTemplate() {
        EmailTemplate emailTemplate = emailTemplateMapper.selectOne(Wrappers.<EmailTemplate>lambdaQuery().eq(EmailTemplate::getId, 1791870020197625858L));
        sendEmail("xaher94124@birige.com", emailTemplate, new HashMap<>());
    }

    @Test
    void updateUserPasswordByAdmin() {
        String encode = passwordEncoder.encode("123456");
        System.out.println(encode);
    }
}