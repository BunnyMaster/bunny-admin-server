package cn.bunny.services.utils;

import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.mapper.system.UserMapper;
import cn.bunny.services.utils.system.UserUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TokenUtilsTest {
    @Autowired
    private UserUtil userUtil;

    @Autowired
    private UserMapper userMapper;

    public String getToken() {
        AdminUser adminUser = userMapper.selectOne(Wrappers.<AdminUser>lambdaQuery().eq(AdminUser::getUsername, "Administrator"));
        adminUser.setPassword("admin123");
        LoginVo loginVo = userUtil.buildLoginUserVo(adminUser, 7);
        return loginVo.getToken();
    }
}
