package cn.bunny.schedule.service.impl;

import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.schedule.dto.ScheduleExecuteLogDto;
import cn.bunny.domain.schedule.entity.ScheduleExecuteLog;
import cn.bunny.domain.schedule.vo.ScheduleExecuteLogVo;
import cn.bunny.schedule.mapper.ScheduleExecuteLogMapper;
import cn.bunny.schedule.service.ScheduleExecuteLogService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 调度任务执行日志 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18 12:56:39
 */
@Service
@Transactional
public class ScheduleExecuteLogServiceImpl extends ServiceImpl<ScheduleExecuteLogMapper, ScheduleExecuteLog> implements ScheduleExecuteLogService {

    /**
     * * 调度任务执行日志 服务实现类
     *
     * @param pageParams 调度任务执行日志分页查询page对象
     * @param dto        调度任务执行日志分页查询对象
     * @return 查询分页调度任务执行日志返回对象
     */
    @Override
    public PageResult<ScheduleExecuteLogVo> getScheduleExecuteLogPage(Page<ScheduleExecuteLog> pageParams, ScheduleExecuteLogDto dto) {
        IPage<ScheduleExecuteLogVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<ScheduleExecuteLogVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 删除|批量删除调度任务执行日志
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteScheduleExecuteLog(List<Long> ids) {
        removeByIds(ids);
    }
}
