package cn.bunny.services.aop.scanner;

import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.service.schedule.impl.SchedulersServiceImpl;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;

import java.lang.annotation.Annotation;
import java.util.HashSet;
import java.util.Set;

/**
 * 扫描指定目录下所有类
 * 传入要扫描的注解类，反射拿到类信息
 * 只需要将反射的类传入到 {@link AbstractAnnotationScanner#getClassesWithAnnotation(Class)}
 *
 * @see SchedulersServiceImpl#getScheduleJobList() <- 其中一个示例
 */
public abstract class AbstractAnnotationScanner {

    // 要扫描哪个包下面的注解
    private static final String basePackage = "cn.bunny.services";

    /**
     * 传入注解，之后反射拿到对应的类
     * 相关使用示例点击引用查看
     *
     * @param annotation 要扫描的注解
     * @return 类
     */
    @SuppressWarnings("unchecked")
    public static Set<Class<?>> getClassesWithAnnotation(Class<?> annotation) {
        // 设置是否延迟初始化
        ClassPathScanningCandidateComponentProvider scanner = new ClassPathScanningCandidateComponentProvider(false);
        // 只需要带有 Annotation 注解类的内容
        scanner.addIncludeFilter(new AnnotationTypeFilter((Class<? extends Annotation>) annotation));

        // 扫描到的内容，排除重复的内容
        Set<Class<?>> classes = new HashSet<>();

        // 只要 cn.bunny.services 包下面的全部内容
        for (BeanDefinition bd : scanner.findCandidateComponents(basePackage)) {
            try {
                // 通过反射加载类，并将类名转换为 Class 对象
                Class<?> clazz = Class.forName(bd.getBeanClassName());
                classes.add(clazz);
            } catch (ClassNotFoundException e) {
                throw new AuthCustomerException(ResultCodeEnum.CLASS_NOT_FOUND);
            }
        }

        return classes;
    }
}