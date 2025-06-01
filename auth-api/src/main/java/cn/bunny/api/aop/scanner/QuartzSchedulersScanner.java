package cn.bunny.api.aop.scanner;

import cn.bunny.core.annotation.QuartzSchedulers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 定时任务扫描注解
 * 扫描方法上加上了 {@link QuartzSchedulers} 的注解
 * 将注解西悉尼返回给前端，前端拿到
 */
public class QuartzSchedulersScanner extends AbstractAnnotationScanner {
    public static List<Map<String, String>> getScheduleJobList() {
        // 通过扫描注解拿到注解列表，反射拿到类信息和注解上标注的内容信息
        Set<Class<?>> classesWithAnnotation = AbstractAnnotationScanner.getClassesWithAnnotation(QuartzSchedulers.class);
        return classesWithAnnotation.stream().map(cls -> {
            Map<String, String> hashMap = new HashMap<>();

            // 调度器引用路径
            String classReference = cls.getName();
            // 调度器详情
            String description = cls.getAnnotation(QuartzSchedulers.class).description();
            // 调度器类型
            String type = cls.getAnnotation(QuartzSchedulers.class).type();

            hashMap.put("value" , classReference);
            hashMap.put("label" , description);
            hashMap.put("type" , type);
            return hashMap;
        }).toList();
    }
}
