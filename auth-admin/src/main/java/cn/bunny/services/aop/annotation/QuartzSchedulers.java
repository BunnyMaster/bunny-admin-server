package cn.bunny.services.aop.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface QuartzSchedulers {
    String value() default "";

    /* 类型 */
    String type();

    /* 详情 */
    String description();
}
