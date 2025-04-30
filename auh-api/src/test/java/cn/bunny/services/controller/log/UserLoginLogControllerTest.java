package cn.bunny.services.controller.log;

import cn.bunny.services.domain.system.log.dto.UserLoginLogDto;
import cn.bunny.services.domain.system.log.entity.UserLoginLog;
import cn.bunny.services.domain.system.log.vo.UserLoginLogLocalVo;
import cn.bunny.services.domain.system.log.vo.UserLoginLogVo;
import cn.bunny.services.domain.common.vo.result.PageResult;
import cn.bunny.services.domain.common.vo.result.Result;
import cn.bunny.services.service.log.UserLoginLogService;
import cn.bunny.services.utils.TokenUtilsTest;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.TypeReference;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.reactive.server.WebTestClient;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;
import java.util.Map;

@Slf4j
@SpringBootTest
@WebAppConfiguration
class UserLoginLogControllerTest {
    private static final String prefix = "/api/userLoginLog";

    private WebTestClient testClient;

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Autowired
    private UserLoginLogService userLoginLogService;

    @Autowired
    private TokenUtilsTest tokenUtils;

    private MockMvc mockMvc;

    private String token;

    @Autowired
    private RestTemplate restTemplate;

    @BeforeEach
    void setUp() {
        token = tokenUtils.getToken();
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
                .apply(SecurityMockMvcConfigurers.springSecurity())
                .build();

        testClient = WebTestClient.bindToController(new UserLoginLogController()).build();
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void getUserLoginLogPage() throws Exception {
        UserLoginLogDto dto = UserLoginLogDto.builder()
                .username("bunny")
                .build();

        mockMvc.perform(MockMvcRequestBuilders.get(prefix + "/getUserLoginLogList/1/10")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(JSON.toJSONString(dto))
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    MockHttpServletResponse response = result.getResponse();
                    String contentAsString = response.getContentAsString();

                    System.out.println(contentAsString);
                });
    }

    @Test
    void getUserLoginLogPage2() {
        UserLoginLogDto dto = UserLoginLogDto.builder()
                .username("bunny")
                .build();
        Map<String, String> params = JSON.parseObject(JSON.toJSONString(dto), new TypeReference<>() {
        });

        // 发送请求
        ResponseEntity<Result<PageResult<UserLoginLogVo>>> response = restTemplate.exchange(
                prefix + "/getUserLoginLogList/1/10",
                HttpMethod.GET,
                new HttpEntity<>(params),
                new ParameterizedTypeReference<>() {
                }
        );

        Result<PageResult<UserLoginLogVo>> body = response.getBody();
        System.out.println(JSON.toJSONString(body));
    }

    @Test
    void getUserLoginLogPageByUser() throws Exception {
        String api = prefix + "/noManage/getUserLoginLogListByLocalUser/1/10";

        mockMvc.perform(MockMvcRequestBuilders.get(api)
                        .header("token", token))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    MockHttpServletResponse response = result.getResponse();
                    String contentAsString = response.getContentAsString();

                    System.out.println(contentAsString);
                });
    }

    @Test
    void getUserLoginLogPageByUser2() {
        String api = prefix + "/noManage/getUserLoginLogListByLocalUser/1/10";

        testClient.get()
                .uri(api)
                .header("token", token)
                .accept(MediaType.APPLICATION_JSON)
                .exchange()
                .expectStatus().isOk()
                .expectBody(new ParameterizedTypeReference<Result<PageResult<UserLoginLogLocalVo>>>() {
                })
                .consumeWith(result -> {
                    Result<PageResult<UserLoginLogLocalVo>> responseBody = result.getResponseBody();
                    System.out.println(JSON.toJSONString(responseBody));
                });
    }

    @Test
    void deleteUserLoginLog() throws Exception {
        String api = prefix + "/deleteUserLoginLog";

        Page<UserLoginLog> page = new Page<>(1, 10);
        List<UserLoginLog> deleteBeforeList = userLoginLogService.list(page);
        List<Long> ids = deleteBeforeList.stream().map(UserLoginLog::getId).limit(4).toList();
        List<Long> deleteBeforeIds = deleteBeforeList.stream().map(UserLoginLog::getId).toList();

        log.info("要删除的ids: {}", ids);
        log.info("删除前ids数据：{}", deleteBeforeIds);

        mockMvc.perform(MockMvcRequestBuilders
                        .delete(api)
                        .header("token", token)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(JSON.toJSONString(ids)))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(result -> {
                    MockHttpServletResponse response = result.getResponse();
                    String contentAsString = response.getContentAsString();
                    System.out.println(contentAsString);
                });

        deleteBeforeList = userLoginLogService.list(page);
        deleteBeforeIds = deleteBeforeList.stream().map(UserLoginLog::getId).toList();
        log.info("要删除的ids: {}", ids);
        log.info("删除前ids数据：{}", deleteBeforeIds);
    }
}