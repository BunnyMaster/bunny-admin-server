package cn.bunny.services.security.filter;


import cn.bunny.dao.dto.user.LoginDto;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.user.LoginVo;
import cn.bunny.services.security.handelr.SecurityAuthenticationFailureHandler;
import cn.bunny.services.security.handelr.SecurityAuthenticationSuccessHandler;
import cn.bunny.services.security.service.CustomUserDetailsService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import java.io.IOException;

import static cn.bunny.common.service.utils.ResponseUtil.out;

/**
 * * UsernamePasswordAuthenticationFilter
 * * 也可以在这里添加验证码、短信等的验证
 * 由于SpringSecurity的登录只能是表单形式 并且用户名密码需要时username、password,可以通过继承 UsernamePasswordAuthenticationFilter 获取登录请求的参数
 * 再去设置到 UsernamePasswordAuthenticationToken 中 来改变请求传参方式、参数名等 或者也可以在登录的时候加入其他参数等等
 */
public class TokenLoginFilterService extends UsernamePasswordAuthenticationFilter {

    private final RedisTemplate<String, Object> redisTemplate;
    private final CustomUserDetailsService customUserDetailsService;
    private LoginDto loginDto;

    public TokenLoginFilterService(AuthenticationConfiguration authenticationConfiguration, RedisTemplate<String, Object> redisTemplate, CustomUserDetailsService customUserDetailsService) throws Exception {
        this.setAuthenticationSuccessHandler(new SecurityAuthenticationSuccessHandler());
        this.setAuthenticationFailureHandler(new SecurityAuthenticationFailureHandler());
        this.setPostOnly(false);
        this.setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher("/admin/login", HttpMethod.POST.name()));
        this.setAuthenticationManager(authenticationConfiguration.getAuthenticationManager());
        this.redisTemplate = redisTemplate;
        this.customUserDetailsService = customUserDetailsService;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            loginDto = objectMapper.readValue(request.getInputStream(), LoginDto.class);

            String emailCode = loginDto.getEmailCode().toLowerCase();
            String username = loginDto.getUsername();
            String password = loginDto.getPassword();

            Object redisEmailCode = redisTemplate.opsForValue().get(RedisUserConstant.getAdminUserEmailCodePrefix(username));
            if (redisEmailCode == null) {
                out(response, Result.error(ResultCodeEnum.EMAIL_CODE_EMPTY));
                return null;
            }

            if (!emailCode.equals(redisEmailCode.toString().toLowerCase())) {
                out(response, Result.error(ResultCodeEnum.EMAIL_CODE_NOT_MATCHING));
                return null;
            }

            Authentication authenticationToken = new UsernamePasswordAuthenticationToken(username, password);
            return getAuthenticationManager().authenticate(authenticationToken);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication auth) {
        LoginVo loginVo = customUserDetailsService.login(loginDto);

        if (loginVo.getStatus() == 1) {
            out(response, Result.error(ResultCodeEnum.FAIL_NO_ACCESS_DENIED_USER_LOCKED));
            return;
        }

        out(response, Result.success(loginVo));
    }

    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) {
        String password = loginDto.getPassword();
        String username = loginDto.getUsername();

        if (password == null || username == null || password.isBlank() || username.isBlank()) {
            out(response, Result.error(ResultCodeEnum.USERNAME_OR_PASSWORD_NOT_EMPTY));
        } else {
            out(response, Result.error(null, ResultCodeEnum.LOGIN_ERROR));
        }
    }
}