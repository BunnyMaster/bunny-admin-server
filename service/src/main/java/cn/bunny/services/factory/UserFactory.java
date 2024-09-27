package cn.bunny.services.factory;

import cn.bunny.common.service.utils.JwtHelper;
import cn.bunny.common.service.utils.ip.IpUtil;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.pojo.constant.LocalDateTimeConstant;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.vo.user.LoginVo;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.mapper.RoleMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Component
@Transactional
public class UserFactory {
    @Autowired
    private PowerMapper powerMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    public LoginVo buildUserVo(AdminUser user, long readMeDay) {
        // 创建token
        Long userId = user.getId();
        String email = user.getEmail();
        String token = JwtHelper.createToken(userId, email, (int) readMeDay);

        // 设置用户IP地址，并更新用户信息
        AdminUser updateUser = new AdminUser();
        updateUser.setId(userId);
        updateUser.setLastLoginIp(IpUtil.getCurrentUserIpAddress().getRemoteAddr());
        updateUser.setLastLoginIpAddress(IpUtil.getCurrentUserIpAddress().getIpRegion());

        // 计算过期时间，并格式化返回
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime plusDay = localDateTime.plusDays(readMeDay);
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS_SLASH);
        String expires = plusDay.format(dateTimeFormatter);

        // 构建返回对象
        LoginVo loginVo = new LoginVo();
        BeanUtils.copyProperties(user, loginVo);
        loginVo.setToken(token);
        loginVo.setRefreshToken(token);
        loginVo.setLastLoginIp(IpUtil.getCurrentUserIpAddress().getRemoteAddr());
        loginVo.setLastLoginIpAddress(IpUtil.getCurrentUserIpAddress().getIpRegion());
        loginVo.setRoleList(roleMapper.selectListByUserId(userId).stream().map(Role::getRoleCode).collect(Collectors.toList()));
        loginVo.setPowerList(powerMapper.selectListByUserId(userId).stream().map(Power::getPowerCode).collect(Collectors.toList()));
        loginVo.setUpdateUser(userId);
        loginVo.setExpires(expires);

        // 将信息保存在Redis中
        redisTemplate.opsForValue().set(RedisUserConstant.getAdminLoginInfoPrefix(email), loginVo, readMeDay, TimeUnit.DAYS);

        // 将Redis中验证码删除
        redisTemplate.delete(RedisUserConstant.getAdminUserEmailCodePrefix(email));

        return loginVo;
    }
}