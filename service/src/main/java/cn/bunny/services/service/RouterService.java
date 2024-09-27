package cn.bunny.services.service;

import cn.bunny.dao.dto.router.RouterManageDto;
import cn.bunny.dao.entity.system.Router;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.router.RouterManageVo;
import cn.bunny.dao.vo.router.UserRouterVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
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
    List<UserRouterVo> getRouterAsync();

    /**
     * * 管理菜单列表
     *
     * @param pageParams 分页想去
     * @param dto        路由查询表单
     * @return 系统菜单表分页
     */
    PageResult<RouterManageVo> getMenusByPage(Page<Router> pageParams, RouterManageDto dto);

    /**
     * * 管理菜单列表
     *
     * @param dto 路由查询表单
     * @return 系统菜单表
     */
    List<RouterManageVo> getMenu(RouterManageDto dto);
}
