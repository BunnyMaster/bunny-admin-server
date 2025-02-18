package cn.bunny.services.security.custom;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.PasswordManagementConfigurer;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.DigestUtils;

/**
 * 自定义密码加密比对
 */
@Configuration
public class CustomPasswordEncoder implements PasswordEncoder, Customizer<PasswordManagementConfigurer<HttpSecurity>> {
    @Override
    public String encode(CharSequence rawPassword) {
        return DigestUtils.md5DigestAsHex(rawPassword.toString().getBytes());
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        return encodedPassword.matches(DigestUtils.md5DigestAsHex(rawPassword.toString().getBytes()));
    }

    @Override
    public void customize(PasswordManagementConfigurer<HttpSecurity> httpSecurityPasswordManagementConfigurer) {
    }
}
