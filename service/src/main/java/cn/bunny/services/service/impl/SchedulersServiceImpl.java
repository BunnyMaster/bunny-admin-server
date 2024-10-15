package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.schedulers.SchedulersAddDto;
import cn.bunny.dao.dto.schedulers.SchedulersDto;
import cn.bunny.dao.dto.schedulers.SchedulersOperationDto;
import cn.bunny.dao.entity.schedulers.Schedulers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.schedulers.SchedulersVo;
import cn.bunny.services.mapper.SchedulersMapper;
import cn.bunny.services.service.SchedulersService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.quartz.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Constructor;
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

    @Autowired
    private Scheduler scheduler;

    /**
     * * Schedulers视图 服务实现类
     *
     * @param pageParams Schedulers视图分页查询page对象
     * @param dto        Schedulers视图分页查询对象
     * @return 查询分页Schedulers视图返回对象
     */
    @Override
    public PageResult<SchedulersVo> getSchedulersList(Page<Schedulers> pageParams, SchedulersDto dto) {
        // 分页查询菜单图标
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
     * 添加Schedulers视图
     *
     * @param dto Schedulers视图添加
     */
    @SuppressWarnings("unchecked")
    @Override
    public void addSchedulers(@Valid SchedulersAddDto dto) {
        try {
            String jobGroup = dto.getJobGroup();
            String jobName = dto.getJobName();
            String cronExpression = dto.getCronExpression();
            String description = dto.getDescription();
            String jobMethodName = dto.getJobMethodName();
            String jobClassName = dto.getJobClassName();


            // 动态创建Class对象
            Class<?> className = Class.forName(jobClassName);
            Constructor<?> constructor = className.getConstructor(); // 获取无参构造函数
            constructor.newInstance(); // 创建实例

            // 创建任务
            JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>) className).withIdentity(jobName, jobGroup)
                    .withDescription(description).build();
            jobDetail.getJobDataMap().put("jobMethodName", jobMethodName);

            // 执行任务
            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);
            CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity("trigger" + jobName, jobGroup)
                    .startNow().withSchedule(cronScheduleBuilder).build();
            scheduler.scheduleJob(jobDetail, trigger);
        } catch (Exception exception) {
            throw new BunnyException(exception.getMessage());
        }
    }

    /**
     * * 暂停Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void pauseScheduler(SchedulersOperationDto dto) {
        try {
            JobKey key = new JobKey(dto.getJobName(), dto.getJobGroup());
            scheduler.pauseJob(key);
        } catch (SchedulerException exception) {
            throw new BunnyException(exception.getMessage());
        }
    }

    /**
     * * 恢复Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void resumeScheduler(SchedulersOperationDto dto) {
        try {
            JobKey key = new JobKey(dto.getJobName(), dto.getJobGroup());
            scheduler.resumeJob(key);
        } catch (SchedulerException exception) {
            throw new BunnyException(exception.getMessage());
        }
    }

    /**
     * * 移出Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    @Override
    public void deleteSchedulers(SchedulersOperationDto dto) {
        try {
            String jobGroup = dto.getJobGroup();
            String jobName = dto.getJobName();

            TriggerKey triggerKey = TriggerKey.triggerKey(jobName, jobGroup);
            scheduler.pauseTrigger(triggerKey);
            scheduler.unscheduleJob(triggerKey);
            scheduler.deleteJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException exception) {
            throw new BunnyException(exception.getMessage());
        }
    }
}
