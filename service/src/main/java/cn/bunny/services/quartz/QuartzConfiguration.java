package cn.bunny.services.quartz;

import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

@Configuration
public class QuartzConfiguration {

    @Autowired
    private QuartzJobFactory quartzJobFactory;

    /**
     * 创建调度器工厂
     * 1.创建SchedulerFactoryBean
     * 2.加载自定义的quartz.properties配置文件
     * 3.设置MyJobFactory
     *
     * @return SchedulerFactoryBean
     */
    @Bean
    public SchedulerFactoryBean schedulerFactoryBean() {
        SchedulerFactoryBean factoryBean = new SchedulerFactoryBean();
        factoryBean.setAutoStartup(true);
        // 延时1秒启动
        factoryBean.setStartupDelay(1);
        factoryBean.setJobFactory(quartzJobFactory);
        return factoryBean;
    }

    @Bean(name = "scheduler")
    public Scheduler scheduler() {
        return schedulerFactoryBean().getScheduler();
    }
}