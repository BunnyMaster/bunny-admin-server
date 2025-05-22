package cn.bunny.services.mapper.system;


import cn.bunny.services.domain.system.entity.router.Router;
import cn.bunny.services.domain.system.vo.router.RouterVo;
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
     * 查询路由列表
     *
     * @return 用户、时间
     */
    List<RouterVo> selectRouterList();
}
