package cn.bunny.services.service.impl;

import cn.bunny.services.aop.AnnotationScanner;
import cn.bunny.services.aop.annotation.QuartzSchedulers;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Set;

@SpringBootTest
class SchedulersServiceImplTest {

    @Autowired
    private AnnotationScanner annotationScanner;

    @Test
    void getAllJobClass() {
        Set<Class<?>> classesWithAnnotation = annotationScanner.getClassesWithAnnotation(QuartzSchedulers.class);
        classesWithAnnotation.forEach(cls -> {
            String classReference = cls.getName();
            String description = cls.getAnnotation(QuartzSchedulers.class).description();
            System.out.println(classReference);
            System.out.println(description);
        });
    }
}