package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.schedulers.SchedulersAddDto;
import cn.bunny.dao.dto.schedulers.SchedulersDto;
import cn.bunny.dao.dto.schedulers.SchedulersOperationDto;
import cn.bunny.dao.entity.schedulers.Schedulers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.schedulers.SchedulersVo;
import cn.bunny.services.aop.AnnotationScanner;
import cn.bunny.services.aop.annotation.QuartzSchedulers;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

    @Autowired
    private AnnotationScanner annotationScanner;

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
            // 动态创建Class对象
            Class<?> className = Class.forName(dto.getJobClassName());

            // 获取无参构造函数
            className.getConstructor().newInstance();

            // 创建任务
            JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>) className)
                    .withIdentity(dto.getJobName(), dto.getJobGroup())
                    .withDescription(dto.getDescription())
                    .build();
            jobDetail.getJobDataMap().put("jobMethodName", "execute");

            // 执行任务
            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(dto.getCronExpression());
            CronTrigger trigger = TriggerBuilder.newTrigger()
                    .withIdentity(dto.getJobName(), dto.getJobGroup())
                    .withDescription(dto.getDescription())
                    .startNow()
                    .withSchedule(cronScheduleBuilder).build();
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

    /**
     * * 获取所有可用调度任务
     *
     * @return 所有调度任务内容
     */
    @Override
    public List<Map<String, String>> getAllScheduleJobList() {
        Set<Class<?>> classesWithAnnotation = annotationScanner.getClassesWithAnnotation(QuartzSchedulers.class);
        return classesWithAnnotation.stream().map(cls -> {
            Map<String, String> hashMap = new HashMap<>();

            // 调度器引用路径
            String classReference = cls.getName();
            // 调度器详情
            String description = cls.getAnnotation(QuartzSchedulers.class).description();

            hashMap.put("value", classReference);
            hashMap.put("label", description);
            return hashMap;
        }).toList();
    }
}
