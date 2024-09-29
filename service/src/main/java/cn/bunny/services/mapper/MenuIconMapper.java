package cn.bunny.services.mapper;

import cn.bunny.dao.dto.menuIcon.MenuIconDto;
import cn.bunny.dao.entity.system.MenuIcon;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 系统菜单图标 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Mapper
public interface MenuIconMapper extends BaseMapper<MenuIcon> {

    /**
     * 分页查询菜单图标
     *
     * @param pageParams 分页查询结果
     * @param dto        系统菜单图标分页查询对象
     * @return 分页查询结果返回内容
     */
    IPage<MenuIcon> selectListByPage(@Param("page") Page<MenuIcon> pageParams, @Param("dto") MenuIconDto dto);
}
