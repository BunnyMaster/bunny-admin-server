package cn.bunny.services.security.config;

import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.security.custom.CustomAuthorizationManagerServiceImpl;
import cn.bunny.services.security.filter.TokenLoginFilterService;
import cn.bunny.services.security.handelr.SecurityAccessDeniedHandler;
import cn.bunny.services.security.handelr.SecurityAuthenticationEntryPoint;
import cn.bunny.services.service.system.UserService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.RegexRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class WebSecurityConfig {

    // 需要排出的无需验证的请求路径
    public static String[] annotations = {
            "/", "/ws/**",
            "/*/*/noAuth/**", "/*/noAuth/**", "/noAuth/**",
            "/media.ico", "/favicon.ico", "*.html", "/webjars/**", "/v3/api-docs/**", "/swagger-ui/**",
            "/error", "/*/i18n/getI18n",
    };

    @Autowired
    private UserService userService;

    @Autowired
    private CustomAuthorizationManagerServiceImpl customAuthorizationManagerService;

    @Autowired
    private AuthenticationConfiguration authenticationConfiguration;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
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
                .sessionManagement(AbstractHttpConfigurer::disable)
                // 前后端分离不需要---记住我
                .rememberMe(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authorize -> authorize.requestMatchers(annotations).permitAll()
                        .requestMatchers(RegexRequestMatcher.regexMatcher(".*\\.(css|js)$")).permitAll()
                        .anyRequest().access(customAuthorizationManagerService))
                .exceptionHandling(exception -> {
                    // 请求未授权接口
                    exception.authenticationEntryPoint(new SecurityAuthenticationEntryPoint());
                    // 没有权限访问
                    exception.accessDeniedHandler(new SecurityAccessDeniedHandler());
                })
                // 登录验证过滤器
                .addFilterBefore(new TokenLoginFilterService(authenticationConfiguration, userService), UsernamePasswordAuthenticationFilter.class);
        return httpSecurity.build();
    }

    /**
     * 使用数据库方式
     * 登录方式：邮箱+用户名
     *
     * @param userMapper 获取用户数据
     * @return 数据库的用户
     */
    @Bean
    public UserDetailsService userDetailsService(UserMapper userMapper) {
        return username -> {
            // 查询用户相关内容
            LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<AdminUser>()
                    .eq(AdminUser::getEmail, username)
                    .or()
                    .eq(AdminUser::getUsername, username);

            // 根据邮箱查询用户名
            AdminUser adminUser = userMapper.selectOne(queryWrapper);
            if (adminUser == null) throw new UsernameNotFoundException(ResultCodeEnum.USER_IS_EMPTY.getMessage());

            return adminUser;
        };
    }
}
