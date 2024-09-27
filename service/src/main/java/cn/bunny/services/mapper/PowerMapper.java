package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.Power;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.jetbrains.annotations.NotNull;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Mapper
public interface PowerMapper extends BaseMapper<Power> {
    /**
     * * 根据用户id查询当前用户所有角色
     *
     * @param userId 用户id
     */
    @NotNull
    List<Power> selectListByUserId(long userId);
}
