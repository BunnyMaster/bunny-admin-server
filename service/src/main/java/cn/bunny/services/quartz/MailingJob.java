package cn.bunny.services.quartz;

import cn.bunny.services.aop.annotation.QuartzSchedulers;
import cn.bunny.services.factory.EmailFactory;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

@QuartzSchedulers(type = "email", description = "定时邮件任务")
public class MailingJob implements Job {
    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        EmailFactory emailFactory = new EmailFactory();
    }
}
