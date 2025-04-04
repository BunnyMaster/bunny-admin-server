package cn.bunny.utils;

public class ConvertUtil {
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
     * @param name               原始名称
     * @param firstLetterCapital 首字母是否大写
     */
    public static String convertToCamelCase(String name, boolean firstLetterCapital) {
        if (name == null || name.isEmpty()) {
            return name;
        }

        StringBuilder result = new StringBuilder();
        String[] parts = name.split("_" );

        for (int i = 0; i < parts.length; i++) {
            String part = parts[i];
            if (part.isEmpty()) {
                continue;
            }

            if (i == 0 && !firstLetterCapital) {
                result.append(part.toLowerCase());
            } else {
                result.append(Character.toUpperCase(part.charAt(0)))
                        .append(part.substring(1).toLowerCase());
            }
        }

        return result.toString();
    }

    /**
     * 辅助方法：将列名转换为字段名(如user_name -> userName)
     *
     * @param columnName 列名称
     * @return 列名称
     */
    public static String convertToFieldName(String columnName) {
        String[] parts = columnName.split("_" );
        StringBuilder fieldName = new StringBuilder(parts[0].toLowerCase());
        for (int i = 1; i < parts.length; i++) {
            fieldName.append(parts[i].substring(0, 1).toUpperCase())
                    .append(parts[i].substring(1).toLowerCase());
        }
        return fieldName.toString();
    }
}
