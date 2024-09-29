package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.menuIcon.MenuIconDto;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.menuIcon.MenuIconVo;
import cn.bunny.services.mapper.MenuIconMapper;
import cn.bunny.services.service.MenuIconService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 系统菜单图标 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
public class MenuIconServiceImpl extends ServiceImpl<MenuIconMapper, MenuIcon> implements MenuIconService {

    /**
     * * 获取菜单Icon
     *
     * @param pageParams 分页查询结果
     * @param dto        系统菜单图标分页查询对象
     * @return 分页查询结果返回内容
     */
    @Override
    public PageResult<MenuIconVo> getMenuIconList(Page<MenuIcon> pageParams, MenuIconDto dto) {
        // 分页查询菜单图标
        IPage<MenuIcon> page = baseMapper.selectListByPage(pageParams, dto);

        List<MenuIconVo> voList = page.getRecords().stream().map(menuIcon -> {
            MenuIconVo menuIconVo = new MenuIconVo();
            BeanUtils.copyProperties(menuIcon, menuIconVo);
            return menuIconVo;
        }).toList();

        return PageResult.<MenuIconVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }
}
