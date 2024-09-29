package cn.bunny.services.service;

import cn.bunny.dao.dto.menuIcon.MenuIconDto;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.menuIcon.MenuIconVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 系统菜单图标 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
public interface MenuIconService extends IService<MenuIcon> {

    /**
     * * 获取菜单Icon
     *
     * @param pageParams 分页查询结果
     * @param dto        系统菜单图标分页查询对象
     * @return 分页查询结果返回内容
     */
    PageResult<MenuIconVo> getMenuIconList(Page<MenuIcon> pageParams, MenuIconDto dto);
}
