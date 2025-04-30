package cn.bunny.core.vms;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import org.apache.velocity.VelocityContext;

import java.io.StringWriter;
import java.util.List;

/**
 * 模板方法模式
 * 如果需要继承 AbstractVmsGenerator
 */
public abstract class AbstractVmsGenerator {

    /**
     * 添加生成内容
     */
    abstract void addContext(VelocityContext context);

    /**
     * Velocity 生成模板
     *
     * @param context VelocityContext
     * @param writer  StringWriter 写入
     */
    abstract void templateMerge(VelocityContext context, StringWriter writer);

    /**
     * 生成模板
     *
     * @param tableMetaData  表属性
     * @param columnInfoList 列属性数组
     * @return StringWriter
     */
    public final StringWriter generatorCodeTemplate(TableMetaData tableMetaData, List<ColumnMetaData> columnInfoList) {
        VelocityContext context = new VelocityContext();

        // 添加要生成的属性
        StringWriter writer = new StringWriter();
        List<String> list = columnInfoList.stream().map(ColumnMetaData::getColumnName).toList();

        // vm 不能直接写 `{` 需要转换下
        context.put("leftBrace", "{");

        // 当前的表名
        context.put("tableName", tableMetaData.getTableName());

        // 当前表的列信息
        context.put("columnInfoList", columnInfoList);

        // 数据库sql列
        context.put("baseColumnList", String.join(",", list));

        // 添加需要生成的内容
        addContext(context);

        templateMerge(context, writer);

        return writer;
    }
}
