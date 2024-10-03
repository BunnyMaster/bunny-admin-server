package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.menuIcon.MenuIconAddDto;
import cn.bunny.dao.dto.system.menuIcon.MenuIconDto;
import cn.bunny.dao.dto.system.menuIcon.MenuIconUpdateDto;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.menuIcon.MenuIconVo;
import cn.bunny.services.mapper.MenuIconMapper;
import cn.bunny.services.service.MenuIconService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 系统菜单图标 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-02 12:18:29
 */
@Service
public class MenuIconServiceImpl extends ServiceImpl<MenuIconMapper, MenuIcon> implements MenuIconService {

    /**
     * * 系统菜单图标 服务实现类
     *
     * @param pageParams 系统菜单图标分页查询page对象
     * @param dto        系统菜单图标分页查询对象
     * @return 查询分页系统菜单图标返回对象
     */
    @Override
    public PageResult<MenuIconVo> getMenuIconList(Page<MenuIcon> pageParams, MenuIconDto dto) {
        // 分页查询菜单图标
        IPage<MenuIcon> page = baseMapper.selectListByPage(pageParams, dto);

        List<MenuIconVo> voList = page.getRecords().stream().map(MenuIcon -> {
            MenuIconVo MenuIconVo = new MenuIconVo();
            BeanUtils.copyProperties(MenuIcon, MenuIconVo);
            return MenuIconVo;
        }).toList();

        return PageResult.<MenuIconVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加系统菜单图标
     *
     * @param dto 系统菜单图标添加
     */
    @Override
    public void addMenuIcon(@Valid MenuIconAddDto dto) {
        // 保存数据
        MenuIcon menuIcon = new MenuIcon();
        BeanUtils.copyProperties(dto, menuIcon);
        save(menuIcon);
    }

    /**
     * 更新系统菜单图标
     *
     * @param dto 系统菜单图标更新
     */
    @Override
    public void updateMenuIcon(@Valid MenuIconUpdateDto dto) {
        // 更新内容
        MenuIcon menuIcon = new MenuIcon();
        BeanUtils.copyProperties(dto, menuIcon);
        updateById(menuIcon);
    }

    /**
     * 删除|批量删除系统菜单图标
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteMenuIcon(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
