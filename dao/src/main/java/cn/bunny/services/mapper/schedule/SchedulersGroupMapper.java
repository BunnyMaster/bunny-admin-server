package cn.bunny.services.mapper.schedule;

import cn.bunny.services.domain.system.quartz.dto.SchedulersGroupDto;
import cn.bunny.services.domain.system.quartz.entity.SchedulersGroup;
import cn.bunny.services.domain.system.quartz.vo.SchedulersGroupVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 任务调度分组 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 20:26:32
 */
@Mapper
public interface SchedulersGroupMapper extends BaseMapper<SchedulersGroup> {

    /**
     * * 分页查询任务调度分组内容
     *
     * @param pageParams 任务调度分组分页参数
     * @param dto        任务调度分组查询表单
     * @return 任务调度分组分页结果
     */
    IPage<SchedulersGroupVo> selectListByPage(@Param("page") Page<SchedulersGroup> pageParams, @Param("dto") SchedulersGroupDto dto);

}
