package cn.bunny.common.service.config;

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
        Contact contact = new Contact().name("Bunny").email("1319900154@qq.com").url("http://z-bunny.cn");
        // 使用协议
        License license = new License().name("MIT").url("http://MUT.com");
        // 相关信息
        Info info = new Info().title("Bunny-Java-Template").description("Bunny的Java模板").version("v1.0.0").contact(contact).license(license).termsOfService("维护不易~求个start");

        return new OpenAPI().info(info).externalDocs(new ExternalDocumentation());
    }

    // 管理员相关分类接口
    @Bean
    public GroupedOpenApi groupedOpenAdminApi() {
        return GroupedOpenApi.builder().group("admin管理员接口请求").pathsToMatch("/admin/**").build();
    }
}
