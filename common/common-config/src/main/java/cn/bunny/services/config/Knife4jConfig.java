package cn.bunny.services.config;

import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import lombok.extern.slf4j.Slf4j;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@Slf4j
public class Knife4jConfig {
    @Bean
    public OpenAPI openAPI() {
        // 作者等信息
        Contact contact = new Contact().name("Bunny").email("1319900154@qq.com").url("http://bunny-web.site");
        // 使用协议
        License license = new License().name("MIT").url("https://mit-license.org");
        // 相关信息
        Info info = new Info().title("Bunny-Admin")
                .contact(contact).license(license)
                .description("权限管理模板")
                .summary("Auth权限模板")
                .termsOfService("http://bunny-web.site")
                .version("v4.0.0");

        return new OpenAPI().info(info).externalDocs(new ExternalDocumentation());
    }

    @Bean
    public GroupedOpenApi all() {
        return GroupedOpenApi.builder().group("全部请求接口").pathsToMatch("/api/**").build();
    }

    @Bean
    public GroupedOpenApi i18n() {
        return GroupedOpenApi.builder().group("多语言").pathsToMatch("/api/i18n/**", "/api/i18nType/**").build();
    }

    @Bean
    public GroupedOpenApi config() {
        return GroupedOpenApi.builder().group("配置")
                .pathsToMatch("/api/config/**", "/api/emailTemplate/**", "/api/emailUsers/**",
                        "/api/message/**", "/api/messageReceived/**", "/api/messageType/**",
                        "/api/menuIcon/**", "/api/schedulers/**", "/api/schedulersGroup/**"
                )
                .build();
    }

    @Bean
    public GroupedOpenApi system() {
        return GroupedOpenApi.builder().group("系统")
                .pathsToMatch("/api/dept/**", "/api/files/**", "/api/power/**",
                        "/api/rolePower/**", "/api/role/**", "/api/router/**",
                        "/api/router/**", "/api/user/**", "/api/userRole/**"
                ).build();
    }

    @Bean
    public GroupedOpenApi log() {
        return GroupedOpenApi.builder().group("日志")
                .pathsToMatch("/api/userLoginLog/**", "/api/quartzExecuteLog/**"
                ).build();
    }
}
