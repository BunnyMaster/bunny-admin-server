package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.menuIcon.MenuIconAddDto;
import cn.bunny.dao.dto.system.menuIcon.MenuIconDto;
import cn.bunny.dao.dto.system.menuIcon.MenuIconUpdateDto;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.MenuIconVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.MenuIconMapper;
import cn.bunny.services.service.MenuIconService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 系统菜单图标 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-02 12:18:29
 */
@Service
@Transactional
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
        IPage<MenuIconVo> page = baseMapper.selectListByPage(pageParams, dto);
        return PageResult.<MenuIconVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 获取查询图标名称列表
     *
     * @param iconName 查询图标名称
     * @return 图标返回列表
     */
    @Override
    public List<MenuIconVo> getIconNameList(String iconName) {
        return list(Wrappers.<MenuIcon>lambdaQuery().like(MenuIcon::getIconName, iconName))
                .stream().collect(Collectors.toMap(MenuIcon::getIconName, menuIcon -> {
                    MenuIconVo menuIconVo = new MenuIconVo();
                    BeanUtils.copyProperties(menuIcon, menuIconVo);
                    return menuIconVo;
                }, (existing, replacement) -> existing)).values().stream().toList();
    }

    /**
     * 添加系统菜单图标
     *
     * @param dto 系统菜单图标添加
     */
    @Override
    @CacheEvict(cacheNames = "menuIcon", key = "'menuIconList'", beforeInvocation = true)
    public void addMenuIcon(MenuIconAddDto dto) {
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
    @CacheEvict(cacheNames = "menuIcon", key = "'menuIconList'", beforeInvocation = true)
    public void updateMenuIcon(@Valid MenuIconUpdateDto dto) {
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
    @CacheEvict(cacheNames = "menuIcon", key = "'menuIconList'", beforeInvocation = true)
    public void deleteMenuIcon(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
