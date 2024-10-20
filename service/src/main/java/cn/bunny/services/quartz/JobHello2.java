package cn.bunny.services.quartz;

import cn.bunny.services.aop.annotation.QuartzSchedulers;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

@Slf4j
@QuartzSchedulers(type = "test", description = "Demo的类JobHello2")
public class JobHello2 implements Job {
    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        System.out.print("执行任务--JobHello2。。。。。。。。。");
    }
}
