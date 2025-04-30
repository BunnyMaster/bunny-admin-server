package cn.bunny.services.service.log.impl;

import cn.bunny.services.domain.system.log.dto.ScheduleExecuteLogDto;
import cn.bunny.services.domain.system.log.entity.ScheduleExecuteLog;
import cn.bunny.services.domain.system.log.vo.ScheduleExecuteLogVo;
import cn.bunny.services.domain.common.vo.result.PageResult;
import cn.bunny.services.mapper.log.ScheduleExecuteLogMapper;
import cn.bunny.services.service.log.ScheduleExecuteLogService;
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
