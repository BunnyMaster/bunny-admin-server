package cn.bunny.services.security.service.iml;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.user.LoginDto;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.user.LoginVo;
import cn.bunny.services.factory.UserFactory;
import cn.bunny.services.mapper.RoleMapper;
import cn.bunny.services.mapper.UserMapper;
import cn.bunny.services.security.custom.CustomUser;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.DigestUtils;

import java.util.List;

@Component
public class CustomUserDetailsServiceImpl implements cn.bunny.services.security.service.CustomUserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserFactory userFactory;
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 查询用户相关内容
        LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<AdminUser>().eq(AdminUser::getEmail, username).or().eq(AdminUser::getUsername, username);

        // 根据邮箱查询用户名
        val user = userMapper.selectOne(queryWrapper);
        if (user == null) throw new UsernameNotFoundException("用户不存在");

        // 根据用户id查询当前用户所有角色
        List<Role> roleList = roleMapper.selectListByUserId(user.getId());
        List<String> roleCodeList = roleList.stream().map(Role::getRoleCode).toList();
        return new CustomUser(user, AuthorityUtils.createAuthorityList(roleCodeList));
    }

    /**
     * 前台用户登录接口
     *
     * @param loginDto 登录参数
     * @return 登录后结果返回
     */
    @Override
    public LoginVo login(LoginDto loginDto) {
        String username = loginDto.getUsername();
        String password = loginDto.getPassword();
        Long readMeDay = loginDto.getReadMeDay();

        // 查询用户相关内容
        LambdaQueryWrapper<AdminUser> queryWrapper = new LambdaQueryWrapper<AdminUser>()
                .eq(AdminUser::getEmail, username)
                .or()
                .eq(AdminUser::getUsername, username);
        AdminUser user = userMapper.selectOne(queryWrapper);

        // 对登录密码进行md5加密判断，是否与数据库中一致
        String md5Password = DigestUtils.md5DigestAsHex(password.getBytes());
        if (!user.getPassword().equals(md5Password)) throw new BunnyException(ResultCodeEnum.LOGIN_ERROR);

        return userFactory.buildUserVo(user, readMeDay);
    }
}
