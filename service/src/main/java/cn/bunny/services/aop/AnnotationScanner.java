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
        ClassPathScanningCandidateComponentProvider scanner = new ClassPathScanningCandidateComponentProvider(false);
        scanner.addIncludeFilter(new AnnotationTypeFilter((Class<? extends Annotation>) annotation));

        Set<Class<?>> classes = new HashSet<>();
        for (BeanDefinition bd : scanner.findCandidateComponents("cn.bunny.services")) {
            try {
                Class<?> clazz = Class.forName(bd.getBeanClassName());
                classes.add(clazz);
            } catch (ClassNotFoundException e) {
                throw new BunnyException(ResultCodeEnum.CLASS_NOT_FOUND);
            }
        }

        return classes;
    }
}