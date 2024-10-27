package cn.bunny.services.mapper;

import cn.bunny.dao.dto.system.rolePower.power.PowerDto;
import cn.bunny.dao.entity.system.Power;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.jetbrains.annotations.NotNull;

import java.util.List;

/**
 * <p>
 * 权限 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
@Mapper
public interface PowerMapper extends BaseMapper<Power> {

    /**
     * * 分页查询权限内容
     *
     * @param pageParams 权限分页参数
     * @param dto        权限查询表单
     * @return 权限分页结果
     */
    IPage<Power> selectListByPage(@Param("page") Page<Power> pageParams, @Param("dto") PowerDto dto);

    /**
     * 物理删除权限
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);

    /**
     * * 根据用户id查询当前用户所有权限
     *
     * @param userId 用户id
     */
    @NotNull
    List<Power> selectListByUserId(long userId);

}
