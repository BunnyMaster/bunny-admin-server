package cn.bunny.services.security.filter;


import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.enums.LoginEnums;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.security.handelr.SecurityAuthenticationFailureHandler;
import cn.bunny.services.security.handelr.SecurityAuthenticationSuccessHandler;
import cn.bunny.services.security.service.CustomUserDetailsService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.util.StringUtils;

import java.io.IOException;

import static cn.bunny.common.service.utils.ResponseUtil.out;

/**
 * * UsernamePasswordAuthenticationFilter
 * * 也可以在这里添加验证码、短信等的验证
 * 由于SpringSecurity的登录只能是表单形式 并且用户名密码需要时username、password,可以通过继承 UsernamePasswordAuthenticationFilter 获取登录请求的参数
 * 再去设置到 UsernamePasswordAuthenticationToken 中 来改变请求传参方式、参数名等 或者也可以在登录的时候加入其他参数等等
 */
public class TokenLoginFilterService extends UsernamePasswordAuthenticationFilter {
    private final CustomUserDetailsService customUserDetailsService;
    private LoginDto loginDto;

    public TokenLoginFilterService(AuthenticationConfiguration authenticationConfiguration, CustomUserDetailsService customUserDetailsService) throws Exception {
        this.setAuthenticationSuccessHandler(new SecurityAuthenticationSuccessHandler());
        this.setAuthenticationFailureHandler(new SecurityAuthenticationFailureHandler());
        this.setPostOnly(false);
        this.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(LoginEnums.LOGIN_REQUEST_API.getValue(), HttpMethod.POST.name()));
        this.setAuthenticationManager(authenticationConfiguration.getAuthenticationManager());
        this.customUserDetailsService = customUserDetailsService;
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
        } catch (IOException e) {
            out(response, Result.error(ResultCodeEnum.ILLEGAL_DATA_REQUEST));
            return null;
        }
    }

    /**
     * 验证成功
     */
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication auth) {
        // 获取登录返回信息
        LoginVo loginVo = customUserDetailsService.login(loginDto, response);
        if (loginVo == null) return;

        // 判断用户是否禁用
        if (loginVo.getStatus()) {
            out(response, Result.error(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED));
            return;
        }

        out(response, Result.success(loginVo));
    }

    /**
     * 验证失败
     */
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {
        String password = loginDto.getPassword();
        String username = loginDto.getUsername();

        if (!StringUtils.hasText(password) || !StringUtils.hasText(username))
            out(response, Result.error(ResultCodeEnum.USERNAME_OR_PASSWORD_NOT_EMPTY));
        else
            out(response, Result.error(null, ResultCodeEnum.LOGIN_ERROR));
    }
}