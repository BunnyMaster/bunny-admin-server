package cn.bunny.services.service.system;

import cn.bunny.domain.system.entity.Router;
import cn.bunny.domain.system.dto.router.RouterAddDto;
import cn.bunny.domain.system.dto.router.RouterManageDto;
import cn.bunny.domain.system.dto.router.RouterUpdateByIdWithRankDto;
import cn.bunny.domain.system.dto.router.RouterUpdateDto;
import cn.bunny.domain.system.vo.router.RouterManageVo;
import cn.bunny.domain.system.vo.router.UserRouterVo;
import cn.bunny.domain.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

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
     * @return 系统菜单表
     */
    List<RouterManageVo> getMenusList(RouterManageDto dto);

    /**
     * * 添加路由菜单
     *
     * @param dto 添加菜单表单
     */
    void addMenu(@Valid RouterAddDto dto);

    /**
     * * 更新路由菜单
     *
     * @param dto 更新表单
     */
    void updateMenu(@Valid RouterUpdateDto dto);

    /**
     * * 删除路由菜单
     *
     * @param ids 删除id列表
     */
    void deletedMenuByIds(List<Long> ids);

    /**
     * * 快速更新菜单排序
     *
     * @param dto 根据菜单Id更新菜单排序
     */
    void updateMenuByIdWithRank(RouterUpdateByIdWithRankDto dto);
}
