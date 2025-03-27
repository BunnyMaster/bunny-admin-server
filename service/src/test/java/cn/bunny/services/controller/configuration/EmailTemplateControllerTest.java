package cn.bunny.services.controller.configuration;

import cn.bunny.dao.dto.system.email.template.EmailTemplateAddDto;
import cn.bunny.dao.dto.system.email.template.EmailTemplateUpdateDto;
import cn.bunny.dao.enums.EmailTemplateEnums;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.system.email.EmailTemplateVo;
import cn.bunny.services.utils.TokenUtilsTest;
import cn.hutool.crypto.digest.MD5;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.TypeReference;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.util.UriComponentsBuilder;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
@WebAppConfiguration
class EmailTemplateControllerTest {
    private static final String prefix = "/api/emailTemplate";

    private String token;

    private MockMvc mockMvc;

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Autowired
    private TokenUtilsTest tokenUtilsTest;

    @Autowired
    private RestTemplate restTemplate;

    @BeforeEach
    void setUp() {
        token = tokenUtilsTest.getToken();
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
                .apply(SecurityMockMvcConfigurers.springSecurity())
                .build();
    }

    @AfterEach
    void tearDown() {

    }

    @Test
    void getEmailTemplateList() throws Exception {
        String api = prefix + "/getEmailTemplateList/1/10";

        mockMvc.perform(MockMvcRequestBuilders
                        .get(api)
                        .header("token", token)
                        .contentType(MediaType.APPLICATION_FORM_URLENCODED_VALUE)
                        .param("type", "code"))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    String contentAsString = result.getResponse().getContentAsString();
                    JSONObject jsonObject = JSONObject.parseObject(contentAsString);

                    if (jsonObject == null) {
                        throw new Exception(contentAsString);
                    }
                    System.out.println(jsonObject);
                });
    }

    @Test
    void getEmailTypes() throws Exception {
        String api = prefix + "/getEmailTypes";

        mockMvc.perform(MockMvcRequestBuilders.get(api).header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    String contentAsString = result.getResponse().getContentAsString();
                    JSONObject jsonObject = JSONObject.parseObject(contentAsString);

                    if (jsonObject == null) {
                        throw new Exception(contentAsString);
                    }

                    System.out.println(jsonObject);
                });
    }

    @Test
    void addEmailTemplate() throws Exception {
        String api = prefix + "/addEmailTemplate";

        EmailTemplateAddDto dto = EmailTemplateAddDto.builder()
                .emailUser(2L)
                .body("哈哈哈")
                .templateName("测试")
                .subject("test")
                .type(EmailTemplateEnums.NOTIFICATION.getType())
                .isDefault(false)
                .build();

        mockMvc.perform(MockMvcRequestBuilders
                        .post(api)
                        .header("token", token)
                        .content(JSONObject.toJSONString(dto))
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    String contentAsString = result.getResponse().getContentAsString();
                    JSONObject jsonObject = JSONObject.parseObject(contentAsString);

                    System.out.println(jsonObject);
                });

        getEmailTemplateList();
    }

    @Test
    void updateEmailTemplate() throws Exception {
        String api = prefix + "/updateEmailTemplate";
        String restTemplateApi = prefix + "/getEmailTemplateList/1/10";

        String url = UriComponentsBuilder.fromUriString(restTemplateApi)
                .queryParam("subject", "test")
                .build()
                .toUriString();

        Result<PageResult<EmailTemplateVo>> result = restTemplate.exchange(
                url,
                HttpMethod.GET,
                new HttpEntity<>(null),
                new ParameterizedTypeReference<Result<PageResult<EmailTemplateVo>>>() {
                }
        ).getBody();

        if (result == null) throw new Exception();
        if (!result.getCode().equals(200)) throw new Exception(result.getMessage());
        if (result.getData().getList().isEmpty()) throw new Exception("没有测试数据");

        EmailTemplateVo emailTemplateVo = result.getData().getList().get(0);
        EmailTemplateUpdateDto emailTemplateUpdateDto = new EmailTemplateUpdateDto();
        BeanUtils.copyProperties(emailTemplateVo, emailTemplateUpdateDto);

        System.out.println(emailTemplateUpdateDto);

        emailTemplateUpdateDto.setBody(MD5.create().digestHex16(LocalDateTime.now().toString()));
        mockMvc.perform(MockMvcRequestBuilders.put(api)
                        .header("token", token)
                        .content(JSON.toJSONString(emailTemplateUpdateDto))
                        .contentType(MediaType.APPLICATION_JSON)
                )
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result1 -> {
                    String contentAsString = result1.getResponse().getContentAsString();
                    var pageResultResult = JSONObject.parseObject(contentAsString, new TypeReference<Result<PageResult<EmailTemplateVo>>>() {
                    });
                    if (pageResultResult == null) throw new Exception(contentAsString);
                    if (!pageResultResult.getCode().equals(200)) throw new Exception(pageResultResult.getMessage());

                    System.out.println(pageResultResult);
                });

        result = restTemplate.exchange(
                url,
                HttpMethod.GET,
                new HttpEntity<>(null),
                new ParameterizedTypeReference<Result<PageResult<EmailTemplateVo>>>() {
                }
        ).getBody();

        if (result == null) throw new Exception();
        if (!result.getCode().equals(200)) throw new Exception(result.getMessage());
        emailTemplateVo = result.getData().getList().get(0);
        if (!emailTemplateVo.getBody().equals(emailTemplateUpdateDto.getBody())) {
            throw new Exception(emailTemplateUpdateDto.getBody());
        }
    }

    @Test
    void deleteEmailTemplate() throws Exception {
        String api = prefix + "/deleteEmailTemplate";
        List<Long> ids = new ArrayList<>();
        ids.add(1905180657917157378L);
        mockMvc.perform(MockMvcRequestBuilders
                        .delete(api)
                        .header("token", token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(JSON.toJSONString(ids)))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    String contentAsString = result.getResponse().getContentAsString();
                    JSONObject jsonObject = JSONObject.parseObject(contentAsString);
                    System.out.println(jsonObject);
                });
    }
}