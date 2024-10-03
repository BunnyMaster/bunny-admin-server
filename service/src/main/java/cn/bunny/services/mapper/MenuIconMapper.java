package cn.bunny.services.mapper;

import cn.bunny.dao.dto.system.menuIcon.MenuIconDto;
import cn.bunny.dao.entity.system.MenuIcon;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 系统菜单图标 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-02 12:18:29
 */
@Mapper
public interface MenuIconMapper extends BaseMapper<MenuIcon> {

    /**
     * * 分页查询系统菜单图标内容
     *
     * @param pageParams 系统菜单图标分页参数
     * @param dto        系统菜单图标查询表单
     * @return 系统菜单图标分页结果
     */
    IPage<MenuIcon> selectListByPage(@Param("page") Page<MenuIcon> pageParams, @Param("dto") MenuIconDto dto);

    /**
     * 物理删除系统菜单图标
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);
}
