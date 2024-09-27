package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.Router;
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
}
