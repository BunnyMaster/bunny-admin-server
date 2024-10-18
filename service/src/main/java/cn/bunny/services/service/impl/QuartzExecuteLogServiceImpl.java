package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.quartz.executeLog.QuartzExecuteLogDto;
import cn.bunny.dao.entity.quartz.QuartzExecuteLog;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.quartz.QuartzExecuteLogVo;
import cn.bunny.services.mapper.QuartzExecuteLogMapper;
import cn.bunny.services.service.QuartzExecuteLogService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

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
public class QuartzExecuteLogServiceImpl extends ServiceImpl<QuartzExecuteLogMapper, QuartzExecuteLog> implements QuartzExecuteLogService {

    /**
     * * 调度任务执行日志 服务实现类
     *
     * @param pageParams 调度任务执行日志分页查询page对象
     * @param dto        调度任务执行日志分页查询对象
     * @return 查询分页调度任务执行日志返回对象
     */
    @Override
    public PageResult<QuartzExecuteLogVo> getQuartzExecuteLogList(Page<QuartzExecuteLog> pageParams, QuartzExecuteLogDto dto) {
        // 分页查询菜单图标
        IPage<QuartzExecuteLog> page = baseMapper.selectListByPage(pageParams, dto);

        List<QuartzExecuteLogVo> voList = page.getRecords().stream().map(quartzExecuteLog -> {
            QuartzExecuteLogVo quartzExecuteLogVo = new QuartzExecuteLogVo();
            BeanUtils.copyProperties(quartzExecuteLog, quartzExecuteLogVo);
            return quartzExecuteLogVo;
        }).toList();

        return PageResult.<QuartzExecuteLogVo>builder()
                .list(voList)
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
    public void deleteQuartzExecuteLog(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
