package cn.bunny.common.generator.utils;

import cn.bunny.common.entity.BaseField;
import cn.bunny.common.entity.StoreTypeField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.lang.reflect.Field;
import java.util.*;

import static cn.bunny.common.generator.WebGeneratorCode.commonPath;

public class GeneratorCodeUtils {
    public static String convertJavaTypeToTypeScript(Class<?> javaType) {
        if (javaType.isPrimitive()) {
            return getPrimitiveTypeMapping(javaType.getSimpleName());
        } else if (javaType.isArray()) {
            return "Array<" + convertJavaTypeToTypeScript(javaType.getComponentType()) + ">";
        } else if (javaType.equals(List.class) || javaType.equals(Set.class) || javaType.equals(Map.class)) {
            return "any";
        } else {
            return getPrimitiveTypeMapping(javaType.getSimpleName());
        }
    }

    /**
     * * 将Java类型转成JS/TS类型
     *
     * @param primitiveType Java的类型
     * @return 转换后的类型
     */
    private static String getPrimitiveTypeMapping(String primitiveType) {
        return switch (primitiveType) {
            case "int", "long", "short", "byte", "float", "double", "Byte", "Integer", "Long", "Float", "Double" ->
                    "number";
            case "boolean", "Boolean" -> "boolean";
            case "char", "Character", "String" -> "string";
            default -> "any";
        };
    }

    /**
     * * 将首字符变小写
     *
     * @param str 字符串
     * @return 变小写后字符串
     */
    public static String lowercaseFirstLetter(String str) {
        if (str == null || str.isEmpty()) return str;
        // 将首字母转换为小写，其余部分保持原样
        return str.substring(0, 1).toLowerCase() + str.substring(1);
    }

    /**
     * * 生成返回对象类字段
     * 返回字段包含：TS接口名称，TS接口名称注释，TS接口字段、TS字段类型、TS字段注释、TS字段注释解释
     *
     * @param voClass 返回对象类
     * @return 整理好返回字段
     */
    public static StoreTypeField handleGenerator(Class<?> voClass) {
        // 类的详细信息
        String interfaceAnnotation = voClass.getAnnotation(ApiModel.class).description();

        // 字段
        List<Field> fields = new ArrayList<>(Arrays.stream(voClass.getDeclaredFields()).toList());
        List<Field> superList = Arrays.stream(voClass.getSuperclass().getDeclaredFields()).toList();
        fields.addAll(superList);

        List<BaseField> list = fields.stream()
                .map(field -> {
                    field.setAccessible(true);

                    // 将类型转成TS
                    Class<?> type = field.getType();
                    String convertJavaTypeToTypeScript = GeneratorCodeUtils.convertJavaTypeToTypeScript(type);

                    // 注释内容
                    String annotationName = Objects.requireNonNull(field.getAnnotation(ApiModelProperty.class).name());
                    // 注释解释
                    String value = field.getAnnotation(ApiModelProperty.class).value();

                    // 构建返回内容
                    BaseField storeTypeField = new BaseField();
                    storeTypeField.setName(field.getName());
                    storeTypeField.setAnnotation(annotationName);
                    storeTypeField.setType(convertJavaTypeToTypeScript);
                    storeTypeField.setDescription(value);

                    return storeTypeField;
                }).toList();

        StoreTypeField storeTypeField = new StoreTypeField();
        storeTypeField.setBaseFieldList(list);
        storeTypeField.setInterfaceName(voClass.getSimpleName());
        storeTypeField.setInterfaceAnnotation(interfaceAnnotation);

        return storeTypeField;
    }

    /**
     * * 通用处理路径内容
     *
     * @param path 路径
     * @return 处理好的路径
     */
    public static String ReplacePathHandle(String path) {
        return path.replace(commonPath, "").replace("\\", "/").replace("src", "@");
    }
}