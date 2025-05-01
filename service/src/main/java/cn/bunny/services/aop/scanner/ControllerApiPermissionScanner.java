package cn.bunny.services.aop.scanner;

import cn.bunny.services.domain.common.model.dto.scanner.ControllerInfo;
import cn.bunny.services.domain.common.model.dto.scanner.MethodInfo;
import cn.bunny.services.domain.common.model.dto.scanner.ScannerControllerInfoVo;
import cn.bunny.services.security.config.WebSecurityConfig;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

/**
 * 控制器扫描APi注解（包含控制器类上的注解 {@link Tag})和 {@link Operation}
 * 将扫描的注解上的信息转成前端所需要的权限格式
 */
public class ControllerApiPermissionScanner extends AbstractAnnotationScanner {

    private static final AntPathMatcher PATH_MATCHER = new AntPathMatcher();

    /**
     * 获取所有带有@Tag注解的控制器类信息
     *
     * @return 包含控制器类信息和接口方法的列表
     */
    public static List<ControllerInfo> scanControllerInfo() {
        Set<Class<?>> controllerClasses = getClassesWithAnnotation(RestController.class);
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

    /**
     * 当前路径是否有权限被添加
     *
     * @param path 请求路径
     * @return boolean
     */
    public static boolean isPathAuthorized(String path) {
        if (!StringUtils.hasText(path)) {
            return true;
        }

        // 需要登录的路径模式检查
        if (path.equals("login")) {
            return false;
        }

        // 需要登录之后才访问的，不需要添加到要被监视的权限中
        for (String userAuth : WebSecurityConfig.userAuths) {
            if (path.contains(userAuth)) {
                return false;
            }
        }

        // 在 WebSecurityConfig 默认配置的不需要权限的路径不添加
        for (String annotation : WebSecurityConfig.annotations) {
            if (PATH_MATCHER.match(annotation, path) || PATH_MATCHER.match(annotation, "/" + path)) {
                return false;
            }
        }

        return true;
    }

    /**
     * 得到所有控制器下的接口路径
     * 其中已经被过滤掉不需要验证的，在 WebSecurityConfig 配置的 annotations
     * 其中已经过滤掉不需要验证的，在 WebSecurityConfig userAuths
     * 在 WebSecurityConfig配置的不会被添加权限中
     *
     * @return 扫描到，且可以被验证的权限
     */
    public static List<ScannerControllerInfoVo> getSystemApiInfoList() {
        // 路径中包含 {xxx} 替换成 *
        String regex = "\\{[^}]*\\}"; // 匹配 {xxx} 格式
        String replacement = "*";     // 替换为 *

        // 控制器中所有的方法路径等
        List<ControllerInfo> controllerInfos = ControllerApiPermissionScanner.scanControllerInfo();
        List<ScannerControllerInfoVo> resultList = new ArrayList<>();

        List<ControllerInfo> controllerInfoList1 = controllerInfos.stream()
                .filter(controllerInfo -> isPathAuthorized(controllerInfo.getBasePath()))
                .toList();

        // 父级RequestMapping中的内容
        for (ControllerInfo controllerInfo : controllerInfoList1) {
            // 处理RequestMapping上开头路径
            String basePath = controllerInfo.getBasePath();
            // 在请求方法前加 /
            if (!basePath.startsWith("/")) basePath = "/" + basePath;
            // 在请求方法路径后加 /
            if (basePath.endsWith("/")) {
                basePath = basePath.substring(1);
            }

            ScannerControllerInfoVo parentVo = ScannerControllerInfoVo.builder()
                    .path(basePath + "/**")
                    .summary(controllerInfo.getTagName())
                    .description(controllerInfo.getTagDescription())
                    .build();

            // 子级 控制器下请求方法
            List<MethodInfo> methods = controllerInfo.getMethods();
            final String finalBasePath = basePath;
            List<ScannerControllerInfoVo> children = methods.stream()
                    .filter(methodInfo -> isPathAuthorized(methodInfo.getPath()))
                    .map(methodInfo -> {
                        String methodInfoPath = methodInfo.getPath();
                        // 为路径添加 /
                        if (StringUtils.hasText(methodInfoPath) && !methodInfoPath.startsWith("/")) {
                            methodInfoPath = finalBasePath + "/" + methodInfoPath;
                            // 路径包含 {xxx} 替换成 *
                            methodInfoPath = methodInfoPath.replaceAll(regex, replacement);
                        } else {
                            methodInfoPath = finalBasePath;
                        }

                        return ScannerControllerInfoVo.builder()
                                .path(methodInfoPath)
                                .httpMethod(methodInfo.getHttpMethod())
                                .summary(methodInfo.getSummary())
                                .description(methodInfo.getDescription())
                                .powerCodes(methodInfo.getTags())
                                .build();
                    }).toList();

            parentVo.setChildren(children);
            resultList.add(parentVo);
        }
        return resultList;
    }
}
