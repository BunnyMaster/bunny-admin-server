package cn.bunny.services.mapper;


import cn.bunny.dao.dto.router.RouterManageDto;
import cn.bunny.dao.entity.system.Router;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-27
 */
@Mapper
public interface RouterMapper extends BaseMapper<Router> {

    /**
     * * 根据用户id查找路由内容
     *
     * @param userId 用户id
     * @return 路由列表
     */
    List<Long> selectListByUserId(Long userId);

    /**
     * * 递归查询所有父级Id，直到查询到父级Id为0
     *
     * @param ids id列表
     * @return 路由列表
     */
    List<Router> selectParentListByRouterId(List<Long> ids);

    /**
     * * 管理菜单列表
     *
     * @param pageParams 分页想去
     * @param dto        路由查询表单
     * @return 分页结果
     */
    IPage<Router> selectListByPage(@Param("page") Page<Router> pageParams, @Param("dto") RouterManageDto dto);

    /**
     * * 物理删除路由菜单
     *
     * @param ids 删除id列表
     */
    void deletedMenuByIds(List<Long> ids);
}
