package cn.bunny.core.vms;

import cn.bunny.core.TypeConvertCore;
import cn.bunny.dao.dto.VmsArgumentDto;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 使用模板方法，方便扩展
 * 如果需要继承 AbstractVmsGenerator
 */
public class VmsArgumentDtoBaseVmsGenerator extends AbstractVmsGenerator {

    private final VmsArgumentDto dto;
    private final String path;

    /**
     * @param dto  类名称可以自定义，格式为 xxx_xxx
     * @param path 当前路径
     */
    public VmsArgumentDtoBaseVmsGenerator(VmsArgumentDto dto, String path) {
        this.dto = dto;
        this.path = path;
    }

    /**
     * 添加生成内容
     *
     * @param context VelocityContext
     */
    @Override
    void addContext(VelocityContext context) {
        // 当前日期
        String date = new SimpleDateFormat(dto.getSimpleDateFormat()).format(new Date());
        context.put("date", date);

        // 作者名字
        context.put("author", dto.getAuthor());

        // 每个 Controller 上的请求前缀
        context.put("requestMapping", dto.getRequestMapping());

        // 表字段的注释内容
        context.put("comment", dto.getComment());

        // 设置包名称
        context.put("package", dto.getPackageName());

        // 类名称如果是小驼峰，需要 [手写] 为 [下划线] 之后由 [代码 -> 小驼峰/大驼峰]
        String className = dto.getClassName();
        // 去除表开头前缀
        String tablePrefixes = dto.getTablePrefixes();
        // 将 表前缀  转成数组
        String replaceTableName = "";
        for (String prefix : tablePrefixes.split("[,，]")) {
            replaceTableName = className.replace(prefix, "");
        }

        // 将类名称转成小驼峰
        String toCamelCase = TypeConvertCore.convertToCamelCase(replaceTableName);
        context.put("classLowercaseName", toCamelCase);

        // 将类名称转成大驼峰
        String convertToCamelCase = TypeConvertCore.convertToCamelCase(replaceTableName, true);
        context.put("classUppercaseName", convertToCamelCase);
    }

    /**
     * Velocity 生成模板
     *
     * @param context VelocityContext
     * @param writer  StringWriter 写入
     */
    @Override
    void templateMerge(VelocityContext context, StringWriter writer) {
        // Velocity 生成模板
        Template servicePathTemplate = Velocity.getTemplate("vms/" + path, "UTF-8");
        servicePathTemplate.merge(context, writer);
    }
}
