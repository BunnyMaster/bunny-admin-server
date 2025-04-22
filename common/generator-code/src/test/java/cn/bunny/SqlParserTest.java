package cn.bunny;

import cn.bunny.core.TypeConvertCore;
import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.statement.Statement;
import net.sf.jsqlparser.statement.create.table.CreateTable;
import org.apache.commons.lang3.StringUtils;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SqlParserTest {

    @Test
    public void test() throws JSQLParserException {
        String sql = """
                CREATE TABLE `sys_files`  (
                  `id` bigint NOT NULL COMMENT '文件的唯一标识符，自动递增',
                  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件的名称',
                  `filepath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件在服务器上的存储路径',
                  `file_size` int NOT NULL COMMENT '文件的大小，以字节为单位',
                  `file_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件的MIME类型',
                  `download_count` int NULL DEFAULT 0 COMMENT '下载数量',
                  `create_user` bigint NOT NULL COMMENT '创建用户',
                  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
                  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
                  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
                  PRIMARY KEY (`id`) USING BTREE,
                  INDEX `idx_filename`(`filename` ASC) USING BTREE COMMENT '索引文件名',
                  INDEX `idx_filepath`(`filepath` ASC) USING BTREE COMMENT '索引文件路径',
                  INDEX `idx_file_type`(`file_type` ASC) USING BTREE COMMENT '索引文件类型',
                  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
                  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
                  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
                  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
                ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统文件表' ROW_FORMAT = DYNAMIC;
                """;

        TableMetaData tableInfo = new TableMetaData();

        // 解析sql
        Statement statement = CCJSqlParserUtil.parse(sql);
        if (!(statement instanceof CreateTable createTable)) {
            throw new IllegalArgumentException("Not a CREATE TABLE statement");
        }

        // 设置表基本信息
        tableInfo.setTableName(createTable.getTable().getName());
        tableInfo.setTableType("TABLE");
        String tableOptionsStrings = String.join(" ", createTable.getTableOptionsStrings());

        // 注释信息
        Pattern pattern = Pattern.compile("COMMENT\\s*=\\s*'(.*?)'", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(tableOptionsStrings);
        if (matcher.find()) {
            tableInfo.setComment(matcher.group(1));
        }

        // 解析列信息
        List<ColumnMetaData> columnMetaData = createTable.getColumnDefinitions()
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

        System.out.println(tableInfo);
        System.out.println("----------------------------------------------------------------------------------------");
        System.out.println(columnMetaData);
    }
}
