package cn.bunny.services.service;

import cn.bunny.dao.dto.quartz.executeLog.QuartzExecuteLogDto;
import cn.bunny.dao.entity.quartz.QuartzExecuteLog;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.quartz.QuartzExecuteLogVo;
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
public interface QuartzExecuteLogService extends IService<QuartzExecuteLog> {

    /**
     * * 获取调度任务执行日志列表
     *
     * @return 调度任务执行日志返回列表
     */
    PageResult<QuartzExecuteLogVo> getQuartzExecuteLogList(Page<QuartzExecuteLog> pageParams, QuartzExecuteLogDto dto);

    /**
     * * 删除|批量删除调度任务执行日志类型
     *
     * @param ids 删除id列表
     */
    void deleteQuartzExecuteLog(List<Long> ids);
}