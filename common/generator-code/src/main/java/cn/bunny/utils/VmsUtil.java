package cn.bunny.utils;

import cn.bunny.dao.dto.VmsArgumentDto;
import com.google.common.base.CaseFormat;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;

public class VmsUtil {

    private static final Map<String, String> TYPE_MAPPINGS = Map.of(
            "controller" , "Controller" ,
            "service" , "Service" ,
            "serviceImpl" , "ServiceImpl" ,
            "mapper" , "Mapper" ,
            "resourceMapper" , "Mapper"
    );

    /**
     * 生成模板
     *
     * @param writer       写入字符串内容
     * @param context      Velocity上下文
     * @param templateName 模板名称
     * @param dto          类名称可以自定义，格式为 xxx_xxx
     */
    public static void commonVms(StringWriter writer, VelocityContext context, String templateName, VmsArgumentDto dto) {
        // 类名称如果是小驼峰，需要 [手写] 为 [下划线] 之后由 [代码 -> 小驼峰/大驼峰]
        String className = dto.getClassName();

        // 去除表开头前缀
        String tablePrefixes = dto.getTablePrefixes();

        // 当前捉着
        String author = dto.getAuthor();

        // 每个 Controller 上的请求前缀
        String requestMapping = dto.getRequestMapping();

        // 将 表前缀  转成数组
        AtomicReference<String> replaceTableName = new AtomicReference<>(className);
        for (String prefix : tablePrefixes.split("[,，]" )) {
            replaceTableName.set(className.replace(prefix, "" ));
        }

        String date = new SimpleDateFormat(dto.getSimpleDateFormat()).format(new Date());
        // vm 不能直接写 `{` 需要转换下
        context.put("leftBrace" , "{" );

        // 当前日期
        context.put("date" , date);

        // 作者名字
        context.put("author" , author);

        // 每个 Controller 上的请求前缀
        context.put("requestMapping" , requestMapping);

        // 将类名称转成小驼峰
        String toCamelCase = ConvertUtil.convertToCamelCase(replaceTableName.get());
        context.put("classLowercaseName" , toCamelCase);

        // 将类名称转成大驼峰
        String convertToCamelCase = ConvertUtil.convertToCamelCase(replaceTableName.get(), true);
        context.put("classUppercaseName" , convertToCamelCase);

        // Velocity 生成模板
        Template servicePathTemplate = Velocity.getTemplate(templateName, "UTF-8" );
        servicePathTemplate.merge(context, writer);
    }

    /**
     * 处理 vm 文件名
     *
     * @param path      文件路径
     * @param className 类名
     */
    public static String handleVmFilename(String path, String className) {
        String[] splitPaths = path.split("/" );
        int splitPathsSize = splitPaths.length - 1;

        // 大驼峰名称
        String CamelCase = ConvertUtil.convertToCamelCase(className, true);
        // 小驼峰名称
        String camelCase = ConvertUtil.convertToCamelCase(className);

        // 当前文件名
        String filename = splitPaths[splitPathsSize];
        filename = filename.replace(".vm" , "" );

        String[] split = filename.split("\\." );
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
        if (filename.contains("java" ) || filename.contains("xml" )) {
            filename = CamelCase + typeMappingsFilename + "." + extension;
        }

        if (filename.contains("vue" ) && !filename.contains("index" )) {
            filename = CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_HYPHEN, camelCase) + "-" + name + "." + extension;
        }

        splitPaths[splitPathsSize] = filename;
        return String.join("/" , splitPaths);
    }
}
