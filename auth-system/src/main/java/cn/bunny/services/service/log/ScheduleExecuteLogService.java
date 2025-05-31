package cn.bunny.services.service.log;

import cn.bunny.domain.model.log.dto.ScheduleExecuteLogDto;
import cn.bunny.domain.model.log.entity.ScheduleExecuteLog;
import cn.bunny.domain.model.log.vo.ScheduleExecuteLogVo;
import cn.bunny.domain.common.model.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 调度任务执行日志 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18 12:56:39
 */
public interface ScheduleExecuteLogService extends IService<ScheduleExecuteLog> {

    /**
     * * 获取调度任务执行日志列表
     *
     * @return 调度任务执行日志返回列表
     */
    PageResult<ScheduleExecuteLogVo> getScheduleExecuteLogPage(Page<ScheduleExecuteLog> pageParams, ScheduleExecuteLogDto dto);

    /**
     * * 删除|批量删除调度任务执行日志类型
     *
     * @param ids 删除id列表
     */
    void deleteScheduleExecuteLog(List<Long> ids);
}
