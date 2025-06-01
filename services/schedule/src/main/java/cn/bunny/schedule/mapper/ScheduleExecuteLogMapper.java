package cn.bunny.schedule.mapper;

import cn.bunny.domain.schedule.dto.ScheduleExecuteLogDto;
import cn.bunny.domain.schedule.entity.ScheduleExecuteLog;
import cn.bunny.domain.schedule.vo.ScheduleExecuteLogVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 调度任务执行日志 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18 12:56:39
 */
@Mapper
public interface ScheduleExecuteLogMapper extends BaseMapper<ScheduleExecuteLog> {

    /**
     * * 分页查询调度任务执行日志内容
     *
     * @param pageParams 调度任务执行日志分页参数
     * @param dto        调度任务执行日志查询表单
     * @return 调度任务执行日志分页结果
     */
    IPage<ScheduleExecuteLogVo> selectListByPage(@Param("page" ) Page<ScheduleExecuteLog> pageParams, @Param("dto" ) ScheduleExecuteLogDto dto);

}
