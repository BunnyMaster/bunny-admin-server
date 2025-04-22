package cn.bunny.core;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import lombok.SneakyThrows;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.create.table.CreateTable;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SqlParserCore {

    /**
     * 解析 sql 表信息
     *
     * @param sql sql字符串
     * @return 表西悉尼
     */
    @SneakyThrows
    public static TableMetaData parserTableInfo(String sql) {
        TableMetaData tableInfo = new TableMetaData();

        // 解析sql
        Statement statement;
        try {
            statement = CCJSqlParserUtil.parse(sql);
        } catch (JSQLParserException e) {
            throw new RuntimeException("SQL解析失败");
        }
        if (!(statement instanceof CreateTable createTable)) {
            throw new IllegalArgumentException("缺少SQL语句");
        }

        // 设置表基本信息
        String tableName = createTable.getTable().getName().replaceAll("`", "");
        tableInfo.setTableName(tableName);
        tableInfo.setTableType("TABLE");
        String tableOptionsStrings = String.join(" ", createTable.getTableOptionsStrings());

        // 注释信息
        Pattern pattern = Pattern.compile("COMMENT\\s*=\\s*'(.*?)'", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(tableOptionsStrings);
        if (matcher.find()) {
            tableInfo.setComment(matcher.group(1));
        }

        return tableInfo;
    }

    /**
     * 解析 sql 列信息
     *
     * @param sql sql字符串
     * @return 列属性列表
     */
    @SneakyThrows
    public static List<ColumnMetaData> parserColumnInfo(String sql) {
        // 解析sql
        Statement statement;
        try {
            statement = CCJSqlParserUtil.parse(sql);
        } catch (JSQLParserException e) {
            throw new RuntimeException("SQL解析失败");
        }

        if (!(statement instanceof CreateTable createTable)) {
            throw new IllegalArgumentException("缺少SQL语句");
        }

        return createTable.getColumnDefinitions()
                .stream().map(column -> {
                    // 列信息
                    ColumnMetaData columnInfo = new ColumnMetaData();

                    // 列名称
                    columnInfo.setColumnName(column.getColumnName());

                    // 设置 JDBC 类型
                    String dataType = column.getColDataType().getDataType();
                    columnInfo.setJdbcType(dataType);

                    // 设置 Java 类型
                    String javaType = TypeConvertCore.convertToJavaType(dataType.contains("varchar") ? "varchar" : dataType);
                    columnInfo.setJavaType(javaType);

                    // 设置 JavaScript 类型
                    columnInfo.setJavascriptType(StringUtils.uncapitalize(javaType));

                    // 列字段转成 下划线 -> 小驼峰
                    columnInfo.setLowercaseName(TypeConvertCore.convertToCamelCase(column.getColumnName()));
                    // 列字段转成 下划线 -> 大驼峰名称
                    columnInfo.setUppercaseName(TypeConvertCore.convertToCamelCase(column.getColumnName(), true));

                    // 解析注释
                    List<String> columnSpecs = column.getColumnSpecs();
                    String columnSpecsString = String.join(" ", columnSpecs);
                    Matcher columnSpecsStringMatcher = Pattern.compile("COMMENT\\s*'(.*?)'", Pattern.CASE_INSENSITIVE).matcher(columnSpecsString);
                    if (columnSpecsStringMatcher.find()) {
                        columnInfo.setComment(columnSpecsStringMatcher.group(1));
                    }

                    return columnInfo;
                }).toList();
    }
}
