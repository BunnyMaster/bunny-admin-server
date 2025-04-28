package cn.bunny.services.utils.system;

import cn.bunny.services.aop.scanner.controller.ControllerInfo;
import cn.bunny.services.aop.scanner.controller.MethodInfo;
import cn.bunny.services.aop.scanner.controller.ScannerControllerInfoVo;
import cn.bunny.services.aop.scanner.controller.utils.ControllerScannerUtil;
import cn.bunny.services.excel.entity.PermissionExcel;
import cn.bunny.services.security.config.WebSecurityConfig;
import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.StringUtils;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class PermissionUtil {
    private static final AntPathMatcher PATH_MATCHER = new AntPathMatcher();

    /**
     * 构建属性结构
     *
     * @param list 要构建的列表
     * @return 构建完成的列表
     */
    public static List<PermissionExcel> buildTree(List<PermissionExcel> list) {
        List<PermissionExcel> permissionExcels = list.stream()
                .filter(permissionExcel -> permissionExcel.getParentId() == null || permissionExcel.getParentId() == 0)
                .toList();

        for (PermissionExcel permission : permissionExcels) {
            setChildren(permission, list);
        }
        return permissionExcels;
    }

    /**
     * 设置子集
     *
     * @param parent 父级节点
     * @param list   要构建的列表
     */
    private static void setChildren(PermissionExcel parent, List<PermissionExcel> list) {
        List<PermissionExcel> children = list.stream()
                .filter(p -> parent.getId().equals(p.getParentId()))
                .toList();

        if (!children.isEmpty()) {
            parent.setChildren(children);

            for (PermissionExcel child : children) {
                setChildren(child, list);
            }
        }
    }

    /**
     * 写入JSON
     *
     * @param list            写入的列表
     * @param zipOutputStream zip输出流
     * @param zipName         zip文件名
     */
    public static void writeJson(List<PermissionExcel> list, ZipOutputStream zipOutputStream, String zipName) {
        try {
            ZipEntry zipEntry = new ZipEntry(zipName);
            zipOutputStream.putNextEntry(zipEntry);
            zipOutputStream.write(JSON.toJSONString(list).getBytes(StandardCharsets.UTF_8));
            zipOutputStream.closeEntry();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 写入JSON
     *
     * @param list            写入的列表
     * @param zipOutputStream zip输出流
     * @param zipName         zip文件名
     */
    public static void writExcel(List<PermissionExcel> list, ZipOutputStream zipOutputStream, String zipName) {
        try {
            ByteArrayOutputStream excelOutputStream = new ByteArrayOutputStream();

            EasyExcel.write(excelOutputStream, PermissionExcel.class).sheet("permission").doWrite(list);

            // 将Excel写入到Zip中
            ZipEntry zipEntry = new ZipEntry(zipName);
            zipOutputStream.putNextEntry(zipEntry);
            zipOutputStream.write(excelOutputStream.toByteArray());
            zipOutputStream.closeEntry();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 将属性结构扁平化
     *
     * @param list 属性结构
     * @return 扁平化数组
     */
    public static List<PermissionExcel> flattenTree(List<PermissionExcel> list) {
        List<PermissionExcel> result = new ArrayList<>();

        for (PermissionExcel node : list) {
            result.add(node);
            if (node.getChildren() != null && !node.getChildren().isEmpty()) {
                result.addAll(flattenTree(node.getChildren()));
            }
        }

        return result;
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
        List<ControllerInfo> controllerInfos = ControllerScannerUtil.scanControllerInfo();
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
