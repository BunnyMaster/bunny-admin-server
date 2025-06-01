package cn.bunny.services.security.config.property;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "auth" )
public class AuthorityProperty {

    /* 需要排出的无需验证的请求路径 */
    private String[] annotations;

    /* 用户登录之后才能访问，不能与接口名称重复和包含！！！ */
    private String[] userAuths;

}
