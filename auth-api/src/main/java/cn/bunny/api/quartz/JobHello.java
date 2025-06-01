package cn.bunny.api.quartz;

import cn.bunny.core.annotation.QuartzSchedulers;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

@Slf4j
@QuartzSchedulers(type = "test" , description = "JobHello任务内容" )
public class JobHello implements Job {

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        // 测试使用
        System.out.print("执行任务--JobHello。。。。。。。。。" );
    }
}
