package cn.bunny.utils;

import cn.bunny.dao.dto.VmsArgumentDto;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;

import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.atomic.AtomicReference;

public class VmsUtil {

    /**
     * @param writer       写入字符串内容
     * @param context      Velocity上下文
     * @param templateName 模板名称
     * @param dto          类名称可以自定义，格式为 xxx_xxx
     */
    public static void commonVms(StringWriter writer, VelocityContext context, String templateName, VmsArgumentDto dto) {
        String className = dto.getClassName();
        String tablePrefixes = dto.getTablePrefixes();
        String author = dto.getAuthor();
        String requestMapping = dto.getRequestMapping();

        AtomicReference<String> replaceTableName = new AtomicReference<>(className);
        for (String prefix : tablePrefixes.split("[,，]" )) {
            replaceTableName.set(className.replace(prefix, "" ));
        }

        String date = new SimpleDateFormat(dto.getSimpleDateFormat()).format(new Date());
        context.put("date" , date);
        context.put("author" , author);
        context.put("requestMapping" , requestMapping);
        context.put("classLowercaseName" , ConvertUtil.convertToCamelCase(replaceTableName.get()));
        context.put("classUppercaseName" , ConvertUtil.convertToCamelCase(replaceTableName.get(), true));

        Template servicePathTemplate = Velocity.getTemplate(templateName, "UTF-8" );
        servicePathTemplate.merge(context, writer);
    }
}
