package cn.bunny.services.service.impl;

import cn.bunny.dao.entity.system.RolePower;
import cn.bunny.services.mapper.RolePowerMapper;
import cn.bunny.services.service.RolePowerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
public class RolePowerServiceImpl extends ServiceImpl<RolePowerMapper, RolePower> implements RolePowerService {

    @Autowired
    private RolePowerMapper rolePowerMapper;

    /**
     * * 根据角色id获取权限内容
     *
     * @param id 角色id
     * @return 已选择的权限列表
     */
    @Override
    public List<String> getPowerListByRoleId(Long id) {
        List<RolePower> rolePowerList = rolePowerMapper.selectPowerListByRoleId(id);
        return rolePowerList.stream().map(rolePower -> rolePower.getPowerId().toString()).toList();
    }
}
