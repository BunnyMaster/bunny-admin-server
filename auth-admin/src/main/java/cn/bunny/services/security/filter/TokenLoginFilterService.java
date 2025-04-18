package cn.bunny.services.security.filter;

import cn.bunny.domain.enums.LoginEnums;
import cn.bunny.domain.system.dto.user.LoginDto;
import cn.bunny.domain.system.vo.user.LoginVo;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.services.security.handelr.SecurityAuthenticationFailureHandler;
import cn.bunny.services.security.handelr.SecurityAuthenticationSuccessHandler;
import cn.bunny.services.service.system.UserService;
import cn.bunny.services.utils.ResponseUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;


/**
 * 自定义登录
 * 自定义登录路径和自定义登录返回数据
 */
public class TokenLoginFilterService extends UsernamePasswordAuthenticationFilter {
    private final UserService userService;
    private LoginDto loginDto;

    public TokenLoginFilterService(AuthenticationConfiguration authenticationConfiguration, UserService customUserDetailsService) throws Exception {
        this.setAuthenticationSuccessHandler(new SecurityAuthenticationSuccessHandler());
        this.setAuthenticationFailureHandler(new SecurityAuthenticationFailureHandler());
        this.setPostOnly(false);
        // 自定义登录路径，自定义登录请求类型
        this.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(LoginEnums.LOGIN_REQUEST_API.getValue(), HttpMethod.POST.name()));
        this.setAuthenticationManager(authenticationConfiguration.getAuthenticationManager());
        this.userService = customUserDetailsService;
    }

    /**
     * * 自定义验证
     * 判断邮箱验证码是否正确
     */
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            loginDto = objectMapper.readValue(request.getInputStream(), LoginDto.class);
            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(loginDto.getUsername(), loginDto.getPassword());
            return getAuthenticationManager().authenticate(authentication);
        } catch (Exception exception) {
            throw new UsernameNotFoundException(exception.getMessage());
        }
    }

    /**
     * 验证成功
     * 在这里用户的账号和密码是对的
     * 此时不要再去解析/转换 request.getInputStream() 因为流已经关闭
     */
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication auth) {
        LoginVo loginVo = userService.login(loginDto, response);
        ResponseUtil.out(response, Result.success(loginVo));
    }

    /**
     * 验证失败
     */
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {
        ResponseUtil.out(response, Result.error(null, failed.getMessage()));
    }
}