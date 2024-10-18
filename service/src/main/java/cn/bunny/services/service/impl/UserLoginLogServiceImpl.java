package cn.bunny.services.service.impl;

import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.services.mapper.UserLoginLogMapper;
import cn.bunny.services.service.UserLoginLogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用户登录日志 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18
 */
@Service
public class UserLoginLogServiceImpl extends ServiceImpl<UserLoginLogMapper, UserLoginLog> implements UserLoginLogService {

}
