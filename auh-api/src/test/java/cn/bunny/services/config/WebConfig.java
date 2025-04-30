package cn.bunny.services.config;

import cn.bunny.services.utils.TokenUtilsTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

@TestConfiguration
public class WebConfig {
    @Value("${server.port}")
    private String port;

    @Autowired
    private TokenUtilsTest tokenUtils;

    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder) {
        String token = tokenUtils.getToken();
        return builder.rootUri("http://localhost:" + port)
                .defaultHeader("token", token)
                .defaultHeader("Content-Type", "application/json")
                .build();
    }
}
