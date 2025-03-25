package cn.bunny.services.aop;

import cn.bunny.dao.constant.LocalDateTimeConstant;
import cn.bunny.dao.entity.log.ScheduleExecuteLog;
import cn.bunny.dao.enums.JobEnums;
import cn.bunny.dao.model.quartz.ScheduleExecuteLogJson;
import cn.bunny.services.mapper.schedule.ScheduleExecuteLogMapper;
import com.alibaba.fastjson2.JSON;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Aspect
@Component
public class JobExecuteAspect {

    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern(LocalDateTimeConstant.YYYY_MM_DD_HH_MM_SS);

    @Autowired
    private ScheduleExecuteLogMapper scheduleExecuteLogMapper;

    @Around(value = "pointCut()")
    public Object aroundMethod(ProceedingJoinPoint joinPoint) {
        Object result;
        Object[] args = joinPoint.getArgs();
        JobExecutionContext context = (JobExecutionContext) args[0];

        // 存储到任务调度日志中
        ScheduleExecuteLog executeLog = new ScheduleExecuteLog();
        ScheduleExecuteLogJson executeLogJson = new ScheduleExecuteLogJson();

        // 格式化时间
        LocalDateTime startLocalDateTime = LocalDateTime.now();
        String startExecuteTIme = startLocalDateTime.format(dateTimeFormatter);

        // 获取上下文map集合
        Map<String, Object> jobDataMap = context.getJobDetail().getJobDataMap().getWrappedMap();
        String jobName = String.valueOf(jobDataMap.get("jobName"));
        String jobGroup = String.valueOf(jobDataMap.get("jobGroup"));
        String cronExpression = String.valueOf(jobDataMap.get("cronExpression"));
        String triggerName = String.valueOf(jobDataMap.get("triggerName"));
        Class<? extends Job> jobClass = context.getJobDetail().getJobClass();

        try {
            // 开始执行
            executeLog.setJobName(jobName);
            executeLog.setJobGroup(jobGroup);
            executeLog.setJobClassName(jobClass.getName());
            executeLog.setCronExpression(cronExpression);
            executeLog.setTriggerName(triggerName);
            // 设置状态结果
            executeLogJson.setResult(JobEnums.UNFINISHED.getType());
            executeLogJson.setStatus(JobEnums.RUNNING.getType());
            executeLogJson.setMessage(JobEnums.RUNNING.getSummary());
            executeLogJson.setOperationTime(startExecuteTIme);
            executeLogJson.setExecuteParams(jobDataMap);
            executeLog.setExecuteResult(JSON.toJSONString(executeLogJson));
            scheduleExecuteLogMapper.insert(executeLog);

            // 执行...
            result = joinPoint.proceed();

            // 设置执行结果-执行任务的日志
            executeLogJson.setResult(JobEnums.FINISH.getType());
            executeLogJson.setStatus(JobEnums.FINISH.getType());
            executeLogJson.setMessage(JobEnums.FINISH.getSummary());
            setEndExecuteLog(executeLogJson, executeLog, startLocalDateTime);
        } catch (Throwable e) {
            // 设置执行结果-执行任务的日志
            executeLogJson.setResult(JobEnums.ERROR.getType());
            executeLogJson.setStatus(JobEnums.ERROR.getType());
            executeLogJson.setMessage(e.getMessage());
            setEndExecuteLog(executeLogJson, executeLog, startLocalDateTime);
            throw new RuntimeException(e);
        }

        return result;
    }

    /**
     * 设置结束日志存储
     */
    private void setEndExecuteLog(ScheduleExecuteLogJson executeLogJson, ScheduleExecuteLog executeLog, LocalDateTime startLocalDateTime) {
        LocalDateTime endLocalDateTime = LocalDateTime.now();
        String endExecuteTime = endLocalDateTime.format(dateTimeFormatter);
        executeLogJson.setOperationTime(endExecuteTime);
        // 设置状态结果
        executeLog.setId(null);
        executeLog.setExecuteResult(JSON.toJSONString(executeLogJson));
        executeLog.setDuration(Duration.between(startLocalDateTime, endLocalDateTime).toSeconds());
        scheduleExecuteLogMapper.insert(executeLog);
    }

    @Pointcut("execution(* cn.bunny.services.quartz.*.execute(..))")
    public void pointCut() {
    }
}
