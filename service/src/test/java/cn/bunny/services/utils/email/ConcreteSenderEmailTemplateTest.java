package cn.bunny.services.utils.email;

import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.services.mapper.configuration.EmailTemplateMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;

@SpringBootTest
class ConcreteSenderEmailTemplateTest extends AbstractSenderEmailTemplate {
    @Autowired
    private EmailTemplateMapper emailTemplateMapper;

    @Test
    void sendEmailTemplate() {
        EmailTemplate emailTemplate = emailTemplateMapper.selectOne(Wrappers.<EmailTemplate>lambdaQuery().eq(EmailTemplate::getId, 1791870020197625858L));
        sendEmail("1319900154@qq.com", emailTemplate, new HashMap<>());
    }
}