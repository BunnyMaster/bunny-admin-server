package cn.bunny.services.security.service.impl;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.enums.LoginEnums;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.security.custom.CustomUser;
import cn.bunny.services.utils.UserUtil;
import cn.bunny.services.utils.login.DefaultLoginStrategy;
import cn.bunny.services.utils.login.EmailLoginStrategy;
import cn.bunny.services.utils.login.LoginContext;
import cn.bunny.services.utils.login.LoginStrategy;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.DigestUtils;
import org.springframework.util.StringUtils;

import java.util.HashMap;

import static cn.bunny.common.service.utils.ResponseUtil.out;

@Component
public class CustomUserDetailsServiceImpl implements cn.bunny.services.security.service.CustomUserDetailsService {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserUtil userUtil;

    /**
     * 根据用户名获取用户对象（获取不到直接抛异常）
     *
     * @param username 用户名
     */
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 查询用户相关内容
        LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<AdminUser>()
                .eq(AdminUser::getEmail, username)
                .or()
                .eq(AdminUser::getUsername, username);

        // 根据邮箱查询用户名
        AdminUser adminUser = userMapper.selectOne(queryWrapper);
        if (adminUser == null) throw new UsernameNotFoundException(ResultCodeEnum.USER_IS_EMPTY.getMessage());

        return new CustomUser(adminUser, AuthorityUtils.createAuthorityList());
    }

    /**
     * 前台用户登录接口
     *
     * @param loginDto 登录参数
     * @return 登录后结果返回
     */
    @Override
    public LoginVo login(LoginDto loginDto, HttpServletResponse response) {
        String password = loginDto.getPassword();
        Long readMeDay = loginDto.getReadMeDay();

        // type不能为空
        String type = loginDto.getType();
        if (!StringUtils.hasText(type)) {
            out(response, Result.error(ResultCodeEnum.REQUEST_IS_EMPTY));
            return null;
        }

        // 初始化登录策略，如果有需要添加策略放在这里
        HashMap<String, LoginStrategy> loginStrategyHashMap = new HashMap<>();
        loginStrategyHashMap.put(LoginEnums.EMAIL_STRATEGY.getValue(), new EmailLoginStrategy(redisTemplate, userMapper));
        loginStrategyHashMap.put(LoginEnums.default_STRATEGY.getValue(), new DefaultLoginStrategy(userMapper));

        // 使用登录上下文调用登录策略
        LoginContext loginContext = new LoginContext(loginStrategyHashMap);
        AdminUser user = loginContext.executeStrategy(type, loginDto, response);

        // 判断用户是否为空
        if (user == null) {
            out(response, Result.error(ResultCodeEnum.LOGIN_ERROR));
            return null;
        }

        // 对登录密码进行md5加密判断，是否与数据库中一致
        String md5Password = DigestUtils.md5DigestAsHex(password.getBytes());
        if (!user.getPassword().equals(md5Password)) throw new AuthCustomerException(ResultCodeEnum.LOGIN_ERROR);

        return userUtil.buildLoginUserVo(user, readMeDay);
    }
}
