package cn.bunny.services.security.filter;


import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.LoginVo;
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

    /**
     * * 自定义验证
     * 判断邮箱验证码是否正确
     */
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            loginDto = objectMapper.readValue(request.getInputStream(), LoginDto.class);

            // type不能为空
            String type = loginDto.getType();
            if (!StringUtils.hasText(type)) {
                out(response, Result.error(ResultCodeEnum.REQUEST_IS_EMPTY));
                return null;
            }

            String emailCode = loginDto.getEmailCode();
            String username = loginDto.getUsername();
            String password = loginDto.getPassword();

            // 如果有邮箱验证码，表示是邮箱登录
            if (type.equals("email")) {
                emailCode = emailCode.toLowerCase();
                Object redisEmailCode = redisTemplate.opsForValue().get(RedisUserConstant.getAdminUserEmailCodePrefix(username));
                if (redisEmailCode == null) {
                    out(response, Result.error(ResultCodeEnum.EMAIL_CODE_EMPTY));
                    return null;
                }

                // 判断用户邮箱验证码是否和Redis中发送的验证码
                if (!emailCode.equals(redisEmailCode.toString().toLowerCase())) {
                    out(response, Result.error(ResultCodeEnum.EMAIL_CODE_NOT_MATCHING));
                    return null;
                }
            }

            Authentication authenticationToken = new UsernamePasswordAuthenticationToken(username, password);
            return getAuthenticationManager().authenticate(authenticationToken);
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