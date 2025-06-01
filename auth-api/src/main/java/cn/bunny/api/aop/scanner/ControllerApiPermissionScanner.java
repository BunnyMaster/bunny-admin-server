package cn.bunny.api.aop.scanner;

import cn.bunny.api.security.config.WebSecurityConfig;
import cn.bunny.core.annotation.PermissionTag;
import cn.bunny.domain.common.model.dto.scanner.ScannerControllerInfoVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Method;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 控制器扫描APi注解（包含控制器类上的注解 {@link Tag})和 {@link Operation}
 * 将扫描的注解上的信息转成前端所需要的权限格式
 */
public class ControllerApiPermissionScanner extends AbstractAnnotationScanner {

    // Ant风格的路径匹配器
    private static final AntPathMatcher PATH_MATCHER = new AntPathMatcher();
    // 路径变量正则表达式，用于匹配如{id}这样的路径参数
    private static final String PATH_VARIABLE_REGEX = "\\{[^}]*\\}";
    // 路径变量的替换字符串
    private static final String PATH_VARIABLE_REPLACEMENT = "*";

    /**
     * 扫描所有带有@RestController注解的类，并处理其中的API信息
     *
     * @return 控制器信息列表
     */
    public static List<ScannerControllerInfoVo> scanControllerInfo() {
        // 获取所有带有@RestController注解的类
        Set<Class<?>> controllerClasses = getClassesWithAnnotation(RestController.class);
        // 处理每个控制器类并收集结果
        return controllerClasses.stream()
                .map(ControllerApiPermissionScanner::processControllerClass)
                .filter(Objects::nonNull)
                .peek(scannerControllerInfoVo -> {
                    String path = scannerControllerInfoVo.getPath();
                    scannerControllerInfoVo.setPath(path + "/**" );
                })
                .collect(Collectors.toList());
    }

    /**
     * 处理单个控制器类
     *
     * @param clazz 控制器类
     * @return 控制器信息对象，如果路径未授权则返回null
     */
    private static ScannerControllerInfoVo processControllerClass(Class<?> clazz) {
        // 从类注解创建基础控制器信息
        ScannerControllerInfoVo controllerInfo = createControllerInfoFromClass(clazz);
        // 检查路径是否已授权
        if (isPathAuthorized(controllerInfo.getPath())) {
            return null;
        }

        // 处理控制器中的所有方法
        List<ScannerControllerInfoVo> methodInfos = processControllerMethods(clazz, controllerInfo.getPath());
        controllerInfo.setChildren(methodInfos);

        return controllerInfo;
    }

    /**
     * 从类注解创建控制器信息
     *
     * @param clazz 控制器类
     * @return 控制器信息对象
     */
    private static ScannerControllerInfoVo createControllerInfoFromClass(Class<?> clazz) {
        ScannerControllerInfoVo info = new ScannerControllerInfoVo();

        // 处理类上的Tag注解
        Optional.ofNullable(clazz.getAnnotation(Tag.class))
                .ifPresent(tag -> {
                    info.setSummary(tag.name());
                    info.setDescription(tag.description());
                });

        // 处理RequestMapping注解获取路径
        processRequestMapping(clazz, info);

        // 处理PermissionTag注解获取权限码
        Optional.ofNullable(clazz.getAnnotation(PermissionTag.class))
                .ifPresent(tag -> {
                    if (StringUtils.hasText(tag.permission())) {
                        info.setPowerCode(tag.permission());
                    }
                });

        return info;
    }

    /**
     * 处理类上的RequestMapping注解
     *
     * @param clazz 控制器类
     * @param info  控制器信息对象
     */
    private static void processRequestMapping(Class<?> clazz, ScannerControllerInfoVo info) {
        Optional.ofNullable(clazz.getAnnotation(RequestMapping.class))
                .filter(mapping -> mapping.value().length > 0)
                .map(mapping -> mapping.value()[0])
                .map(path -> {
                    // 确保路径以/开头且不以/结尾
                    if (!path.startsWith("/" )) path = "/" + path;
                    return path.endsWith("/" ) ? path.substring(1) : path;
                })
                .ifPresent(info::setPath);
    }

    /**
     * 处理控制器类中的所有方法
     *
     * @param clazz    控制器类
     * @param basePath 控制器基础路径
     * @return 方法信息列表
     */
    private static List<ScannerControllerInfoVo> processControllerMethods(Class<?> clazz, String basePath) {
        return Arrays.stream(clazz.getDeclaredMethods())
                .map(method -> createMethodInfo(method, basePath))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    /**
     * 创建方法信息对象
     *
     * @param method   控制器方法
     * @param basePath 控制器基础路径
     * @return 方法信息对象，如果路径未授权则返回null
     */
    private static ScannerControllerInfoVo createMethodInfo(Method method, String basePath) {
        ScannerControllerInfoVo methodInfo = new ScannerControllerInfoVo();

        // 处理Operation注解获取方法摘要和描述
        Optional.ofNullable(method.getAnnotation(Operation.class))
                .ifPresent(operation -> {
                    methodInfo.setSummary(operation.summary());
                    methodInfo.setDescription(operation.description());
                });

        // 构建完整方法路径
        String methodPath = buildMethodPath(method, basePath);
        methodInfo.setPath(methodPath);
        // 检查路径是否已授权
        if (isPathAuthorized(methodPath)) {
            return null;
        }

        // 处理HTTP方法类型
        Optional.ofNullable(getHttpMethod(method))
                .ifPresent(methodInfo::setHttpMethod);

        // 处理PermissionTag注解获取权限码
        Optional.ofNullable(method.getAnnotation(PermissionTag.class))
                .ifPresent(tag -> methodInfo.setPowerCode(tag.permission()));

        return methodInfo;
    }

    /**
     * 构建方法的完整路径
     *
     * @param method   控制器方法
     * @param basePath 控制器基础路径
     * @return 完整路径（将路径变量替换为*）
     */
    private static String buildMethodPath(Method method, String basePath) {
        String methodPath = getMethodPath(method);
        if (methodPath == null) {
            return basePath;
        }

        // 确保路径格式正确
        if (!methodPath.startsWith("/" )) methodPath = "/" + methodPath;
        if (methodPath.endsWith("/" )) {
            methodPath = methodPath.substring(1);
        }

        // 合并基础路径和方法路径，并替换路径变量
        return basePath + methodPath.replaceAll(PATH_VARIABLE_REGEX, PATH_VARIABLE_REPLACEMENT);
    }

    /**
     * 获取HTTP方法类型
     *
     * @param method 控制器方法
     * @return HTTP方法类型字符串（GET/POST/PUT/DELETE/PATCH）
     */
    private static String getHttpMethod(Method method) {
        if (method.getAnnotation(GetMapping.class) != null) return "GET";
        if (method.getAnnotation(PostMapping.class) != null) return "POST";
        if (method.getAnnotation(PutMapping.class) != null) return "PUT";
        if (method.getAnnotation(DeleteMapping.class) != null) return "DELETE";
        if (method.getAnnotation(PatchMapping.class) != null) return "PATCH";

        // 处理RequestMapping注解中的method属性
        RequestMapping requestMapping = method.getAnnotation(RequestMapping.class);
        if (requestMapping != null && requestMapping.method().length > 0) {
            return requestMapping.method()[0].name();
        }
        return null;
    }

    /**
     * 获取方法上的路径值
     *
     * @param method 控制器方法
     * @return 方法路径
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

    /**
     * 检查路径是否已被授权（不需要权限控制）
     *
     * @param path 请求路径
     * @return 如果路径已授权返回true，否则返回false
     */
    public static boolean isPathAuthorized(String path) {
        if (!StringUtils.hasText(path)) {
            return false;
        }

        // 检查用户认证路径
        for (String userAuth : WebSecurityConfig.userAuths) {
            if (path.contains(userAuth)) return true;
        }

        // 检查不需要权限的注解路径
        for (String annotation : WebSecurityConfig.annotations) {
            if (PATH_MATCHER.match(annotation, path) || PATH_MATCHER.match(annotation, "/" + path)) return true;
        }

        return false;
    }
}