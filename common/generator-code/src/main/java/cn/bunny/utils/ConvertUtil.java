package cn.bunny.utils;

import com.google.common.base.CaseFormat;
import org.assertj.core.util.introspection.CaseFormatUtils;

import java.util.regex.Pattern;

public class ConvertUtil {

    /**
     * 将数据库类型转换为Java类型
     */
    public static String convertToJavaType(String columnType) {
        if (columnType == null) return "Object";

        columnType = columnType.toLowerCase();
        return switch (columnType) {
            case "varchar", "char", "text", "longtext", "mediumtext", "tinytext" -> "String";
            case "int", "integer", "tinyint", "smallint" -> "Integer";
            case "bigint" -> "Long";
            case "decimal", "numeric" -> "BigDecimal";
            case "float" -> "Float";
            case "double" -> "Double";
            case "boolean", "bit", "tinyint unsigned" -> "Boolean";
            case "date", "year" -> "Date";
            case "time" -> "Time";
            case "datetime", "timestamp" -> "LocalDateTime";
            case "blob", "longblob", "mediumblob", "tinyblob" -> "byte[]";
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

        // 首字母不大写
        if (!firstLetterCapital) return CaseFormatUtils.toCamelCase(name);

        // 检查是否全大写带下划线 (UPPER_UNDERSCORE)
        if (Pattern.matches("^[A-Z]+(_[A-Z]+)*$", name)) {
            return CaseFormat.UPPER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, name);
        }

        // 检查是否小写带下划线 (LOWER_UNDERSCORE)
        if (Pattern.matches("^[a-z]+(_[a-z]+)*$", name)) {
            return CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, name);
        }

        // 检查是否大驼峰 (UpperCamelCase)
        if (Character.isUpperCase(name.charAt(0)) &&
                !name.contains("_") &&
                name.chars().anyMatch(Character::isLowerCase)) {
            return CaseFormat.UPPER_CAMEL.to(CaseFormat.UPPER_CAMEL, name);
        }

        // 默认认为是小驼峰 (lowerCamelCase)
        return CaseFormat.LOWER_CAMEL.to(CaseFormat.UPPER_CAMEL, name);
    }
}
