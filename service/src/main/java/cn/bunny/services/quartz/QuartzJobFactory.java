package cn.bunny.services.quartz;

import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.quartz.spi.TriggerFiredBundle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.scheduling.quartz.AdaptableJobFactory;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class QuartzJobFactory extends AdaptableJobFactory {

    // 这个对象Spring会帮我们自动注入进来
    @Autowired
    private AutowireCapableBeanFactory capableBeanFactory;

    // 重写创建Job任务的实例方法
    @NotNull
    @Override
    protected Object createJobInstance(@NotNull TriggerFiredBundle bundle) throws Exception {
        Object jobInstance = super.createJobInstance(bundle);
        // 通过以下方式，解决Job任务无法使用Spring中的Bean问题
        capableBeanFactory.autowireBean(jobInstance);
        return super.createJobInstance(bundle);
    }
}