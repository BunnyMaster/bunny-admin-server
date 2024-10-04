package cn.bunny.services.service.impl;

import cn.bunny.dao.entity.system.UserDept;
import cn.bunny.services.mapper.UserDeptMapper;
import cn.bunny.services.service.UserDeptService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 部门用户关系表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@Service
public class UserDeptServiceImpl extends ServiceImpl<UserDeptMapper, UserDept> implements UserDeptService {

}
