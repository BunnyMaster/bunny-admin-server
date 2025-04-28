package cn.bunny.services.aop.scanner.controller.utils;

import cn.bunny.services.aop.scanner.AnnotationScanner;
import cn.bunny.services.aop.scanner.controller.ControllerInfo;
import cn.bunny.services.aop.scanner.controller.MethodInfo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

/**
 * 控制器扫描工具类
 */
public class ControllerScannerUtil {

    /**
     * 获取所有带有@Tag注解的控制器类信息
     *
     * @return 包含控制器类信息和接口方法的列表
     */
    public static List<ControllerInfo> scanControllerInfo() {
        Set<Class<?>> controllerClasses = AnnotationScanner.getClassesWithAnnotation(RestController.class);
        List<ControllerInfo> controllerInfos = new ArrayList<>();

        for (Class<?> clazz : controllerClasses) {
            ControllerInfo controllerInfo = new ControllerInfo();

            // 获取类上的Tag注解
            Tag tag = clazz.getAnnotation(Tag.class);
            if (tag != null) {
                controllerInfo.setTagName(tag.name());
                controllerInfo.setTagDescription(tag.description());
            }

            // 获取类上的RequestMapping注解
            RequestMapping requestMapping = clazz.getAnnotation(RequestMapping.class);
            if (requestMapping != null && requestMapping.value().length > 0) {
                controllerInfo.setBasePath(requestMapping.value()[0]);
            }

            // 获取方法上的注解信息
            List<MethodInfo> methodInfos = new ArrayList<>();
            for (Method method : clazz.getDeclaredMethods()) {
                MethodInfo methodInfo = new MethodInfo();

                // 获取Operation注解
                Operation operation = method.getAnnotation(Operation.class);
                if (operation != null) {
                    methodInfo.setSummary(operation.summary());
                    methodInfo.setDescription(operation.description());
                    methodInfo.setTags(Arrays.stream(operation.tags()).toList());
                }

                // 获取请求路径和方法的组合路径
                String methodPath = getMethodPath(method);
                if (methodPath != null) {
                    methodInfo.setPath(methodPath);
                }

                // 获取请求方法类型
                String httpMethod = getHttpMethod(method);
                if (httpMethod != null) {
                    methodInfo.setHttpMethod(httpMethod);
                }

                if (operation != null || methodPath != null) {
                    methodInfos.add(methodInfo);
                }
            }

            controllerInfo.setMethods(methodInfos);
            controllerInfos.add(controllerInfo);
        }

        return controllerInfos;
    }

    /**
     * 获取HTTP方法类型
     */
    private static String getHttpMethod(Method method) {
        if (method.getAnnotation(GetMapping.class) != null) return "GET";
        if (method.getAnnotation(PostMapping.class) != null) return "POST";
        if (method.getAnnotation(PutMapping.class) != null) return "PUT";
        if (method.getAnnotation(DeleteMapping.class) != null) return "DELETE";
        if (method.getAnnotation(PatchMapping.class) != null) return "PATCH";

        RequestMapping requestMapping = method.getAnnotation(RequestMapping.class);
        if (requestMapping != null && requestMapping.method().length > 0) {
            return requestMapping.method()[0].name();
        }
        return null;
    }

    /**
     * 获取方法上的路径注解值
     */
    private static String getMethodPath(Method method) {
        // 检查所有可能的路径注解
        GetMapping getMapping = method.getAnnotation(GetMapping.class);
        if (getMapping != null && getMapping.value().length > 0) {
            return getMapping.value()[0];
        }

        PostMapping postMapping = method.getAnnotation(PostMapping.class);
        if (postMapping != null && postMapping.value().length > 0) {
            return postMapping.value()[0];
        }

        PutMapping putMapping = method.getAnnotation(PutMapping.class);
        if (putMapping != null && putMapping.value().length > 0) {
            return putMapping.value()[0];
        }

        DeleteMapping deleteMapping = method.getAnnotation(DeleteMapping.class);
        if (deleteMapping != null && deleteMapping.value().length > 0) {
            return deleteMapping.value()[0];
        }

        PatchMapping patchMapping = method.getAnnotation(PatchMapping.class);
        if (patchMapping != null && patchMapping.value().length > 0) {
            return patchMapping.value()[0];
        }

        RequestMapping requestMapping = method.getAnnotation(RequestMapping.class);
        if (requestMapping != null && requestMapping.value().length > 0) {
            return requestMapping.value()[0];
        }

        return null;
    }
}
