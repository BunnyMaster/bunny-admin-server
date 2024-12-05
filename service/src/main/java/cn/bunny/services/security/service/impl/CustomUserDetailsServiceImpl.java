package cn.bunny.services.security.service.impl;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.dao.dto.system.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.security.custom.CustomUser;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.DigestUtils;

import static cn.bunny.common.service.utils.ResponseUtil.out;

@Component
public class CustomUserDetailsServiceImpl implements cn.bunny.services.security.service.CustomUserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserFactory userFactory;

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
        String username = loginDto.getUsername();
        String password = loginDto.getPassword();
        Long readMeDay = loginDto.getReadMeDay();

        // 查询用户相关内容
        LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<>();
        if (loginDto.getType().equals("email")) {
            queryWrapper.eq(AdminUser::getEmail, username);
        } else {
            queryWrapper.eq(AdminUser::getUsername, username);
        }
        AdminUser user = userMapper.selectOne(queryWrapper);

        // 判断用户是否为空
        if (user == null) {
            out(response, Result.error(ResultCodeEnum.LOGIN_ERROR));
            return null;
        }

        // 对登录密码进行md5加密判断，是否与数据库中一致
        String md5Password = DigestUtils.md5DigestAsHex(password.getBytes());
        if (!user.getPassword().equals(md5Password)) throw new AuthCustomerException(ResultCodeEnum.LOGIN_ERROR);

        return userFactory.buildLoginUserVo(user, readMeDay);
    }
}
