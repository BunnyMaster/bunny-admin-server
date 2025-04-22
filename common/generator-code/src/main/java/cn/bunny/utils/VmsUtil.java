package cn.bunny.utils;

import cn.bunny.core.TypeConvertCore;
import com.google.common.base.CaseFormat;

import java.util.Map;

public class VmsUtil {

    private static final Map<String, String> TYPE_MAPPINGS = Map.of(
            "controller", "Controller",
            "service", "Service",
            "serviceImpl", "ServiceImpl",
            "mapper", "Mapper",
            "resourceMapper", "Mapper"
    );

    /**
     * 处理 vm 文件名
     *
     * @param path      文件路径
     * @param className 类名
     */
    public static String handleVmFilename(String path, String className) {
        String[] splitPaths = path.split("/");
        int splitPathsSize = splitPaths.length - 1;

        // 大驼峰名称
        String CamelCase = TypeConvertCore.convertToCamelCase(className, true);
        // 小驼峰名称
        String camelCase = TypeConvertCore.convertToCamelCase(className);

        // 当前文件名
        String filename = splitPaths[splitPathsSize];
        filename = filename.replace(".vm", "");

        String[] split = filename.split("\\.");
        // 文件名称
        String name = split[0];
        // 文件扩展名
        String extension = "";
        if (split.length >= 2) {
            extension = split[1];
        }

        // 判断是否是 Java 或者 xml 文件
        String typeMappingsFilename = TYPE_MAPPINGS.get(name);
        typeMappingsFilename = typeMappingsFilename == null ? "" : typeMappingsFilename;
        if (filename.contains("java") || filename.contains("xml")) {
            filename = CamelCase + typeMappingsFilename + "." + extension;
        }

        if (filename.contains("vue") && !filename.contains("index")) {
            filename = CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_HYPHEN, camelCase) + "-" + name + "." + extension;
        }

        splitPaths[splitPathsSize] = filename;
        return String.join("/", splitPaths);
    }
}
