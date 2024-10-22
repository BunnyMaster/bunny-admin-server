package cn.bunny.services.aop;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.stereotype.Component;

import java.lang.annotation.Annotation;
import java.util.HashSet;
import java.util.Set;

/**
 * * 扫描指定目录下所有类
 */
@Component
public class AnnotationScanner {

    @SuppressWarnings("unchecked")
    public Set<Class<?>> getClassesWithAnnotation(Class<?> annotation) {
        // 设置是否延迟初始化
        ClassPathScanningCandidateComponentProvider scanner = new ClassPathScanningCandidateComponentProvider(false);
        // 只需要带有 Annotation 注解类的内容
        scanner.addIncludeFilter(new AnnotationTypeFilter((Class<? extends Annotation>) annotation));

        // 扫描到的内容，排除重复的内容
        Set<Class<?>> classes = new HashSet<>();

        // 只要 cn.bunny.services 包下面的全部内容
        for (BeanDefinition bd : scanner.findCandidateComponents("cn.bunny.services")) {
            try {
                // 通过反射加载类，并将类名转换为 Class 对象
                Class<?> clazz = Class.forName(bd.getBeanClassName());
                classes.add(clazz);
            } catch (ClassNotFoundException e) {
                throw new BunnyException(ResultCodeEnum.CLASS_NOT_FOUND);
            }
        }

        return classes;
    }
}