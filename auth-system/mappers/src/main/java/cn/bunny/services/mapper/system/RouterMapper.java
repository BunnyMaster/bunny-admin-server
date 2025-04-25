package cn.bunny.services.mapper.system;


import cn.bunny.domain.system.entity.Router;
import cn.bunny.domain.system.vo.router.RouterVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

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
     * 物理删除路由菜单
     *
     * @param ids 删除id列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);

    /**
     * 查询路由列表
     *
     * @return 用户、时间
     */
    List<RouterVo> selectMenuList();
}
