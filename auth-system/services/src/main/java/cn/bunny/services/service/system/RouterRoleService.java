package cn.bunny.services.service.system;

import cn.bunny.domain.system.entity.RouterRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
public interface RouterRoleService extends IService<RouterRole> {

    /**
     * * 根据路由id获取所有角色
     *
     * @param routerId 路由id
     * @return 角色列表
     */
    List<String> getRoleListByRouterId(Long routerId);

    /**
     * 清除选中菜单所有角色
     *
     * @param routerIds 路由id
     */
    void clearAllRolesSelect(List<Long> routerIds);
}
