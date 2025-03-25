package cn.bunny.services.controller.configuration;

import cn.bunny.dao.dto.system.configuration.WebConfigurationDto;
import cn.bunny.dao.entity.configuration.WebConfiguration;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.utils.UserUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.TypeReference;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.concurrent.atomic.AtomicReference;

@SpringBootTest
@WebAppConfiguration
class ConfigurationControllerTest {
    private static final String prefix = "/api/config";

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Autowired
    private UserUtil userUtil;

    @Autowired
    private UserMapper userMapper;

    private String token;

    private MockMvc mockMvc;

    @BeforeEach
    void setUpMockMvc() {
        AdminUser adminUser = userMapper.selectOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getUsername, "Administrator"));
        adminUser.setPassword("admin123");
        LoginVo loginVo = userUtil.buildLoginUserVo(adminUser, 7);
        token = loginVo.getToken();

        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
                .apply(SecurityMockMvcConfigurers.springSecurity())
                .build();
    }

    @Test
    void webConfig() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders
                        .get(prefix + "/noAuth/webConfig")
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    MockHttpServletResponse response = result.getResponse();
                    String contentAsString = response.getContentAsString();

                    WebConfiguration webConfiguration = JSON.parseObject(contentAsString, WebConfiguration.class);

                    if (!webConfiguration.getTitle().equals("BunnyAdmin")) {
                        throw new Exception();
                    }


                    System.out.println(webConfiguration);
                });
    }

    @Test
    void getWebConfig() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders
                        .request(HttpMethod.GET, prefix + "/getWebConfig")
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    MockHttpServletResponse response = result.getResponse();
                    String contentAsString = response.getContentAsString();

                    Result<WebConfiguration> webConfigurationResult = JSON.parseObject(contentAsString, new TypeReference<>() {
                    });

                    if (!webConfigurationResult.getCode().equals(200)) {
                        throw new Exception();
                    }

                    if (!webConfigurationResult.getData().getShowModel().equals("smart")) {
                        throw new Exception();
                    }
                    System.out.println(contentAsString);
                });
    }

    @Test
    void updateWebConfiguration() throws Exception {
        AtomicReference<WebConfigurationDto> webConfigurationDto = new AtomicReference<>();
        String testTitle = "修改的之";

        // 获取原本的配置信息
        mockMvc.perform(MockMvcRequestBuilders
                        .request(HttpMethod.GET, prefix + "/getWebConfig")
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    MockHttpServletResponse response = result.getResponse();
                    String contentAsString = response.getContentAsString();

                    System.out.println(contentAsString);

                    Result<WebConfiguration> webConfigurationResult = JSON.parseObject(contentAsString, new TypeReference<>() {
                    });

                    WebConfigurationDto dto = new WebConfigurationDto();
                    BeanUtils.copyProperties(webConfigurationResult.getData(), dto);

                    webConfigurationDto.set(dto);
                });

        // 修改原本的测试内容
        webConfigurationDto.get().setTitle(testTitle);

        // 测试修改方法
        mockMvc.perform(MockMvcRequestBuilders.put(prefix + "/updateWebConfiguration")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(JSON.toJSONString(webConfigurationDto.get()))
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    String contentAsString = result.getResponse().getContentAsString();

                    System.out.println(contentAsString);

                    Result<String> stringResult = JSON.parseObject(contentAsString, new TypeReference<>() {
                    });

                    if (!stringResult.getCode().equals(200)) {
                        throw new Exception();
                    }
                });

        // 验证是否修改成功
        mockMvc.perform(MockMvcRequestBuilders
                        .request(HttpMethod.GET, prefix + "/getWebConfig")
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    MockHttpServletResponse response = result.getResponse();
                    String contentAsString = response.getContentAsString();

                    Result<WebConfiguration> webConfigurationResult = JSON.parseObject(contentAsString, new TypeReference<>() {
                    });

                    if (!webConfigurationResult.getCode().equals(200)) {
                        throw new Exception();
                    }

                    if (!webConfigurationResult.getData().getTitle().equals(testTitle)) {
                        throw new Exception();
                    }
                    System.out.println(contentAsString);
                });
    }
}