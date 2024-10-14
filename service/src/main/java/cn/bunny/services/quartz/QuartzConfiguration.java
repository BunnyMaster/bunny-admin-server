package cn.bunny.services.quartz;

import org.quartz.Scheduler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import java.io.IOException;
import java.util.Properties;

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
        try {
            factoryBean.setAutoStartup(true);
            // 延时3秒启动
            factoryBean.setStartupDelay(3);
            factoryBean.setQuartzProperties(quartzProperties());
            factoryBean.setJobFactory(quartzJobFactory);
            return factoryBean;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @Bean
    public Properties quartzProperties() throws IOException {
        PropertiesFactoryBean propertiesFactoryBean = new PropertiesFactoryBean();
        propertiesFactoryBean.setLocation(new ClassPathResource("/quartz.properties"));
        propertiesFactoryBean.afterPropertiesSet();
        return propertiesFactoryBean.getObject();
    }

    @Bean(name = "scheduler")
    public Scheduler scheduler() {
        return schedulerFactoryBean().getScheduler();
    }
}