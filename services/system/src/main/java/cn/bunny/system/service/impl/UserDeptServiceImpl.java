package cn.bunny.system.service.impl;

import cn.bunny.domain.system.entity.UserDept;
import cn.bunny.system.mapper.UserDeptMapper;
import cn.bunny.system.service.UserDeptService;
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
