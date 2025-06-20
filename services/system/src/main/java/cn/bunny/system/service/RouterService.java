package cn.bunny.system.service;

import cn.bunny.domain.system.dto.RouterDto;
import cn.bunny.domain.system.entity.router.Router;
import cn.bunny.domain.system.vo.router.RouterManageVo;
import cn.bunny.domain.system.vo.router.WebUserRouterVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-27
 */
public interface RouterService extends IService<Router> {
    /**
     * * 获取路由内容
     *
     * @return 路遇列表
     */
    List<WebUserRouterVo> routerAsync();

    /**
     * * 管理菜单列表
     *
     * @return 系统菜单表
     */
    List<RouterManageVo> routerList();

    /**
     * * 添加路由菜单
     *
     * @param dto 添加菜单表单
     */
    void createRouter(RouterDto dto);

    /**
     * * 更新路由菜单
     *
     * @param dto 更新表单
     */
    void updateRouter(RouterDto dto);

    /**
     * * 删除路由菜单
     *
     * @param ids 删除id列表
     */
    void deletedRouterByIds(List<Long> ids);
}
