package cn.bunny.services.quartz;

import cn.bunny.services.factory.EmailFactory;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class MailingJob implements Job {
    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        EmailFactory emailFactory = new EmailFactory();
    }
}
