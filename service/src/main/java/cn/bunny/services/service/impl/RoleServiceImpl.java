package cn.bunny.services.service.impl;

import cn.bunny.dao.entity.system.Role;
import cn.bunny.services.mapper.RoleMapper;
import cn.bunny.services.service.RoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

}
