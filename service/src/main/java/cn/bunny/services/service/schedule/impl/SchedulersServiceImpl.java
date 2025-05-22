package cn.bunny.services.service.schedule.impl;

import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.schedule.dto.SchedulersDto;
import cn.bunny.services.domain.schedule.entity.Schedulers;
import cn.bunny.services.domain.schedule.vo.SchedulersVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.schedule.SchedulersMapper;
import cn.bunny.services.service.schedule.SchedulersService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.quartz.*;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * <p>
 * Schedulers视图 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 16:35:10
 */
@Service
public class SchedulersServiceImpl extends ServiceImpl<SchedulersMapper, Schedulers> implements SchedulersService {

    @Resource
    private Scheduler scheduler;


    /**
     * * Schedulers视图 服务实现类
     *
     * @param pageParams Schedulers视图分页查询page对象
     * @param dto        Schedulers视图分页查询对象
     * @return 查询分页Schedulers视图返回对象
     */
    @Override
    public PageResult<SchedulersVo> getSchedulersPage(Page<Schedulers> pageParams, SchedulersDto dto) {
        IPage<Schedulers> page = baseMapper.selectListByPage(pageParams, dto);

        List<SchedulersVo> voList = page.getRecords().stream().map(schedulers -> {
            SchedulersVo schedulersVo = new SchedulersVo();
            BeanUtils.copyProperties(schedulers, schedulersVo);
            return schedulersVo;
        }).toList();

        return PageResult.<SchedulersVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 更新任务
     *
     * @param dto 更新任务表单
     */
    @Override
    public void updateSchedulers(SchedulersDto dto) {
        String jobName = dto.getJobName();
        String jobGroup = dto.getJobGroup();
        String cronExpression = dto.getCronExpression();

        CronTrigger trigger = TriggerBuilder.newTrigger()
                .withIdentity(jobName, jobGroup)
                .withDescription(dto.getDescription())
                .startNow()
                .withSchedule(CronScheduleBuilder.cronSchedule(cronExpression))
                .build();

        try {
            TriggerKey key = new TriggerKey(jobName, jobGroup);
            Trigger oldTrigger = scheduler.getTrigger(key);
            Date date = scheduler.rescheduleJob(oldTrigger.getKey(), trigger);
            if (date == null) {
                throw new AuthCustomerException(ResultCodeEnum.UPDATE_ERROR);
            }
        } catch (SchedulerException e) {
            throw new AuthCustomerException(ResultCodeEnum.UPDATE_ERROR);
        }
    }

    /**
     * 添加Schedulers视图
     *
     * @param dto Schedulers视图添加
     */
    @SuppressWarnings("unchecked")
    @Override
    public void createSchedulers(SchedulersDto dto) {
        String jobName = dto.getJobName();
        String jobGroup = dto.getJobGroup();
        String cronExpression = dto.getCronExpression();

        try {
            // 动态创建Class对象
            Class<?> clazz = Class.forName(dto.getJobClassName());

            // 获取无参构造函数
            clazz.getConstructor().newInstance();

            // 创建任务
            JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>) clazz)
                    .withIdentity(jobName, jobGroup)
                    .withDescription(dto.getDescription())
                    .build();

            // 执行任务
            CronTrigger trigger = TriggerBuilder.newTrigger()
                    .withIdentity(jobName, jobGroup)
                    .withDescription(dto.getDescription())
                    .startNow()
                    .withSchedule(CronScheduleBuilder.cronSchedule(cronExpression))
                    .build();

            // 设置任务map值
            JobDataMap jobDataMap = jobDetail.getJobDataMap();
            jobDataMap.put("jobName", jobName);
            jobDataMap.put("jobGroup", jobGroup);
            jobDataMap.put("cronExpression", cronExpression);
            jobDataMap.put("triggerName", trigger.getKey().getName());

            scheduler.scheduleJob(jobDetail, trigger);
        } catch (Exception exception) {
            throw new AuthCustomerException(exception.getMessage());
        }
    }

    /**
     * * 暂停Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void pauseScheduler(SchedulersDto dto) {
        try {
            JobKey key = new JobKey(dto.getJobName(), dto.getJobGroup());
            scheduler.pauseJob(key);
        } catch (SchedulerException exception) {
            throw new AuthCustomerException(exception.getMessage());
        }
    }

    /**
     * * 恢复Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void resumeScheduler(SchedulersDto dto) {
        try {
            JobKey key = new JobKey(dto.getJobName(), dto.getJobGroup());
            scheduler.resumeJob(key);
        } catch (SchedulerException exception) {
            throw new AuthCustomerException(exception.getMessage());
        }
    }

    /**
     * * 移出Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void deleteSchedulers(SchedulersDto dto) {
        try {
            String jobGroup = dto.getJobGroup();
            String jobName = dto.getJobName();

            TriggerKey triggerKey = TriggerKey.triggerKey(jobName, jobGroup);
            scheduler.pauseTrigger(triggerKey);
            scheduler.unscheduleJob(triggerKey);
            scheduler.deleteJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException exception) {
            throw new AuthCustomerException(exception.getMessage());
        }
    }
}
