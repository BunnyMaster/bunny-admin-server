package cn.bunny.services.service.impl;


import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.services.mapper.EmailUsersMapper;
import cn.bunny.services.service.EmailUsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * 邮箱发送表 服务实现类
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
public class EmailUsersServiceImpl extends ServiceImpl<EmailUsersMapper, EmailUsers> implements EmailUsersService {

}