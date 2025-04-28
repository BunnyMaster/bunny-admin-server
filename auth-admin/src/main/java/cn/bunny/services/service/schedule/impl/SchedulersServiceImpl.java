package cn.bunny.services.service.schedule.impl;

import cn.bunny.domain.quartz.dto.SchedulersAddDto;
import cn.bunny.domain.quartz.dto.SchedulersDto;
import cn.bunny.domain.quartz.dto.SchedulersUpdateDto;
import cn.bunny.domain.quartz.entity.Schedulers;
import cn.bunny.domain.quartz.vo.SchedulersVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.aop.annotation.QuartzSchedulers;
import cn.bunny.services.aop.scanner.AnnotationScanner;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.schedule.SchedulersMapper;
import cn.bunny.services.service.schedule.SchedulersService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.quartz.*;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.*;

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
     * * 获取所有可用调度任务
     *
     * @return 所有调度任务内容
     */
    @Override
    public List<Map<String, String>> getScheduleJobList() {
        // 通过扫描注解拿到注解列表，反射拿到类信息和注解上标注的内容信息
        Set<Class<?>> classesWithAnnotation = AnnotationScanner.getClassesWithAnnotation(QuartzSchedulers.class);
        return classesWithAnnotation.stream().map(cls -> {
            Map<String, String> hashMap = new HashMap<>();

            // 调度器引用路径
            String classReference = cls.getName();
            // 调度器详情
            String description = cls.getAnnotation(QuartzSchedulers.class).description();
            // 调度器类型
            String type = cls.getAnnotation(QuartzSchedulers.class).type();

            hashMap.put("value", classReference);
            hashMap.put("label", description);
            hashMap.put("type", type);
            return hashMap;
        }).toList();
    }

    /**
     * 更新任务
     *
     * @param dto 更新任务表单
     */
    @Override
    public void updateSchedulers(SchedulersUpdateDto dto) {
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
    public void addSchedulers(@Valid SchedulersAddDto dto) {
        String jobName = dto.getJobName();
        String jobGroup = dto.getJobGroup();
        String cronExpression = dto.getCronExpression();

        try {
            // 动态创建Class对象
            Class<?> className = Class.forName(dto.getJobClassName());

            // 获取无参构造函数
            className.getConstructor().newInstance();

            // 创建任务
            JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>) className)
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
    public void pauseScheduler(SchedulersUpdateDto dto) {
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
    public void resumeScheduler(SchedulersUpdateDto dto) {
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
    public void deleteSchedulers(SchedulersUpdateDto dto) {
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
