package cn.bunny.api.security.config;

import cn.bunny.api.security.config.property.AuthorityProperty;
import cn.bunny.api.security.handler.SecurityAccessDeniedHandler;
import cn.bunny.api.security.handler.SecurityAuthenticationEntryPoint;
import cn.bunny.api.security.service.CustomAuthorizationManagerServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.RegexRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class WebSecurityConfig {

    // 需要排出的无需验证的请求路径
    // public static String[] annotations = {
    //         "/" , "/ws/**" , "/**.html" , "/error" ,
    //         "/media.ico" , "/favicon.ico" , "/webjars/**" , "/v3/api-docs/**" , "/swagger-ui/**" ,
    //         "/*/*/login" , "/*/local-file/**" , "/*/*/public/**" ,
    // };
    public static String[] annotations;

    // 用户登录之后才能访问，不能与接口名称重复！！！不能与接口名称包含！！！
    // public static String[] userAuths = {"private"};
    public static String[] userAuths;

    private final AuthorityProperty authorityProperty;
    private final CustomAuthorizationManagerServiceImpl customAuthorizationManagerService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        annotations = authorityProperty.getAnnotations();
        userAuths = authorityProperty.getUserAuths();

        httpSecurity
                // 前端段分离不需要---禁用明文验证
                .httpBasic(AbstractHttpConfigurer::disable)
                // 前端段分离不需要---禁用默认登录页
                .formLogin(AbstractHttpConfigurer::disable)
                // 前端段分离不需要---禁用退出页
                .logout(AbstractHttpConfigurer::disable)
                // 前端段分离不需要---csrf攻击
                .csrf(AbstractHttpConfigurer::disable)
                // 跨域访问权限，如果需要可以关闭后自己配置跨域访问
                .cors(AbstractHttpConfigurer::disable)
                // 前后端分离不需要---因为是无状态的
                // .sessionManagement(AbstractHttpConfigurer::disable)
                .sessionManagement(session ->
                        session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                // 前后端分离不需要---记住我
                .rememberMe(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers(annotations).permitAll()
                        .requestMatchers(RegexRequestMatcher.regexMatcher(".*\\.(css|js)$" )).permitAll()
                        .anyRequest().access(customAuthorizationManagerService)
                )
                .exceptionHandling(exception -> {
                    // 请求未授权接口
                    exception.authenticationEntryPoint(new SecurityAuthenticationEntryPoint());
                    // 没有权限访问
                    exception.accessDeniedHandler(new SecurityAccessDeniedHandler());
                })
        ;

        return httpSecurity.build();
    }
}
