package cn.bunny.core;

import com.google.common.base.CaseFormat;
import org.assertj.core.util.introspection.CaseFormatUtils;

/* 类型转换，数据库转Java类型等 */
public class TypeConvertCore {

    /**
     * 将数据库类型转换为Java类型
     */
    public static String convertToJavaType(String columnType) {
        if (columnType == null) return "Object";

        columnType = columnType.toLowerCase();
        return switch (columnType) {
            case "varchar" , "char" , "text" , "longtext" , "mediumtext" , "tinytext" -> "String";
            case "int" , "integer" , "tinyint" , "smallint" -> "Integer";
            case "bigint" -> "Long";
            case "decimal" , "numeric" -> "BigDecimal";
            case "float" -> "Float";
            case "double" -> "Double";
            case "boolean" , "bit" , "tinyint unsigned" -> "Boolean";
            case "date" , "year" -> "Date";
            case "time" -> "Time";
            case "datetime" , "timestamp" -> "LocalDateTime";
            case "blob" , "longblob" , "mediumblob" , "tinyblob" -> "byte[]";
            default -> "Object";
        };
    }

    /**
     * 下划线命名转驼峰命名
     */
    public static String convertToCamelCase(String name) {
        return convertToCamelCase(name, false);
    }

    /**
     * 下划线命名转驼峰命名
     *
     * @param name               原始名称，传入的值可以是
     *                           `xxx_xxx` `CaseFormat`
     *                           `caseFormat`
     * @param firstLetterCapital 首字母是否大写
     */
    public static String convertToCamelCase(String name, boolean firstLetterCapital) {
        if (name == null || name.isEmpty()) return name;

        // 转成小驼峰
        String lowerCamelCase = CaseFormatUtils.toCamelCase(name);

        // 首字母不大写
        if (!firstLetterCapital) {
            return lowerCamelCase;
        }

        // 将小驼峰转成大驼峰
        return CaseFormat.LOWER_CAMEL.to(CaseFormat.UPPER_CAMEL, lowerCamelCase);
    }
}
