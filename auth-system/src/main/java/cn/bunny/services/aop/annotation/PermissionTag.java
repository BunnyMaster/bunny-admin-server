package cn.bunny.services.aop.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 这个可加可不加，只是在系统初始化的时候会方便一点
 * 如果要批量添加接口，可以这样做
 */
@Target({ElementType.TYPE, ElementType.METHOD, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface PermissionTag {

    /* 权限标识 */
    String permission() default "";

    /* 详情 */
    String description() default "";
}
