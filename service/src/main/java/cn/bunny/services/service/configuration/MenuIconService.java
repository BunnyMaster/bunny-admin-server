package cn.bunny.services.service.configuration;

import cn.bunny.services.domain.menuIcon.dto.MenuIconAddDto;
import cn.bunny.services.domain.menuIcon.dto.MenuIconDto;
import cn.bunny.services.domain.menuIcon.dto.MenuIconUpdateDto;
import cn.bunny.services.domain.menuIcon.entity.MenuIcon;
import cn.bunny.services.domain.menuIcon.vo.MenuIconVo;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 系统菜单图标 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-02 12:18:29
 */
public interface MenuIconService extends IService<MenuIcon> {

    /**
     * * 获取系统菜单图标列表
     *
     * @return 系统菜单图标返回列表
     */
    PageResult<MenuIconVo> getMenuIconPage(Page<MenuIcon> pageParams, MenuIconDto dto);

    /**
     * * 添加系统菜单图标
     *
     * @param dto 添加表单
     */
    void addMenuIcon(@Valid MenuIconAddDto dto);

    /**
     * * 更新系统菜单图标
     *
     * @param dto 更新表单
     */
    void updateMenuIcon(@Valid MenuIconUpdateDto dto);

    /**
     * * 删除|批量删除系统菜单图标类型
     *
     * @param ids 删除id列表
     */
    void deleteMenuIcon(List<Long> ids);

    /**
     * * 获取查询图标名称列表
     *
     * @param iconName 查询图标名称
     * @return 图标返回列表
     */
    List<MenuIconVo> getIconNameListByIconName(String iconName);
}
