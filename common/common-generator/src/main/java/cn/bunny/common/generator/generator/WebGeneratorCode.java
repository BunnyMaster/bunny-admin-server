package cn.bunny.common.generator.generator;

import cn.bunny.admin.dto.admin.AdminPowerAddDto;
import cn.bunny.admin.dto.admin.AdminPowerDto;
import cn.bunny.admin.dto.admin.AdminPowerUpdateDto;
import cn.bunny.admin.entity.admin.AdminPower;
import cn.bunny.admin.vo.admin.AdminPowerVo;
import cn.bunny.common.entity.BaseField;
import cn.bunny.common.entity.ColumnsField;
import cn.bunny.common.entity.StoreTypeField;
import cn.bunny.common.utils.GeneratorCodeUtils;
import com.google.common.base.CaseFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.springframework.stereotype.Service;

import java.io.FileWriter;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

/**
 * * 代码生成器入口点
 */
@Service
public class WebGeneratorCode {
    // 公共路径
    public static String commonPath = "D:\\MyFolder\\Bunny\\BunnyBBS\\BunnyBBS-admin\\";
    // public static String commonPath = "D:\\Project\\web\\PC\\BunnyNote\\BunnyBBS-admin\\";
    // 生成API请求路径
    public static String apiPath = commonPath + "src\\api\\api-v1\\user\\";
    // 生成的表格列表路径
    public static String columnsPath = commonPath + "src\\views\\user\\admin\\admin-power-management\\utils\\";
    // 生成vue路径
    public static String vuePath = commonPath + "src\\views\\user\\admin\\admin-power-management\\";
    // 生成仓库路径
    public static String storePath = commonPath + "src\\store\\user\\";
    // 生成仓库类型
    public static String storeTypePath = commonPath + "src\\types\\store\\user\\admin\\";
    // 公共i18n字段前缀
    public static String commonPreFix = "adminPower";

    public static void main(String[] args) throws Exception {
        Class<?> aClass = AdminPower.class;
        Class<?> dtoClass = AdminPowerDto.class;
        Class<?> addDtoClass = AdminPowerAddDto.class;
        Class<?> updateDtoClass = AdminPowerUpdateDto.class;
        Class<?> voClass = AdminPowerVo.class;

        ArrayList<Class<?>> classList = new ArrayList<>();
        classList.add(voClass);
        classList.add(dtoClass);
        classList.add(addDtoClass);
        classList.add(updateDtoClass);

        // 开始生成内容
        generatorCode(aClass, voClass, dtoClass, addDtoClass, classList);
    }

    /**
     * * 代码生成
     */
    public static void generatorCode(Class<?> aClass, Class<?> voClass, Class<?> dtoClass, Class<?> addDtoClass, ArrayList<Class<?>> classList) throws Exception {
        // 设置velocity资源加载器
        Properties prop = new Properties();
        prop.put("file.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        Velocity.init(prop);
        // 创建Velocity容器
        VelocityContext context = new VelocityContext();

        // 原始类名称
        String originalName = aClass.getSimpleName();
        // 转成开头小写类名称，作为文件名
        String lowercaseName = originalName.substring(0, 1).toLowerCase() + originalName.substring(1);
        // 转成中划线，做vue命名使用
        String lowerHyphen = CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_HYPHEN, originalName);
        // 基础TS 的 interface 注释内容
        String interfaceDescription = aClass.getAnnotation(ApiModel.class).description();

        Field[] fields = voClass.getDeclaredFields();
        // 生成 Columns 字段
        List<ColumnsField> columnsField = Arrays.stream(fields)
                .map(field -> ColumnsField.builder().name(field.getName()).value(field.getAnnotation(ApiModelProperty.class).value()).build())
                .toList();
        // 整合仓库集合 interface 集合列表
        List<StoreTypeField> fieldList = classList.stream().map(GeneratorCodeUtils::handleGenerator).toList();

        // 生成 Store 中 form 表单内容
        List<BaseField> formList = Arrays.stream(dtoClass.getDeclaredFields())
                .filter(field -> !field.getName().equals("id"))
                .map(field -> BaseField.builder().name(field.getName()).annotation(field.getAnnotation(ApiModelProperty.class).name()).build())
                .toList();

        // 生成dialog字段
        List<BaseField> addDtoFormList = Arrays.stream(addDtoClass.getDeclaredFields())
                .map(addDto -> {
                    BaseField baseField = new BaseField();
                    baseField.setName(addDto.getName());
                    baseField.setAnnotation(addDto.getAnnotation(ApiModelProperty.class).name());

                    // 是否有验证内容
                    List<Annotation> validationList = Arrays.stream(addDto.getAnnotations())
                            .filter(annotation -> {
                                Class<? extends Annotation> annotationType = annotation.annotationType();
                                return annotationType.getTypeName().contains("jakarta.validation.constraints");
                            })
                            .peek(annotation -> {
                                try {
                                    String message = annotation.annotationType().getMethod("message").invoke(annotation).toString();
                                    baseField.setRequireMessage(message);
                                    baseField.setRequire(true);
                                } catch (Exception e) {
                                    baseField.setRequireMessage(null);
                                    baseField.setRequire(false);
                                }
                            }).toList();

                    baseField.setRequire(!validationList.isEmpty());

                    return baseField;
                })
                .toList();

        context.put("columnsField", columnsField);
        context.put("fields", fieldList);
        context.put("annotationName", aClass.getAnnotation(ApiModel.class).description());
        context.put("storeId", GeneratorCodeUtils.lowercaseFirstLetter(originalName));
        context.put("formList", formList);
        context.put("addDtoFormList", addDtoFormList);
        context.put("className", originalName);
        context.put("interfaceDescription", interfaceDescription);
        context.put("lowerHyphen", lowerHyphen);
        context.put("lowercaseName", lowercaseName);
        context.put("commonPreFix", commonPreFix);

        // 添加路径内
        context.put("columnsPath", GeneratorCodeUtils.ReplacePathHandle(columnsPath));
        context.put("vuePath", GeneratorCodeUtils.ReplacePathHandle(vuePath));
        context.put("storePath", GeneratorCodeUtils.ReplacePathHandle(storePath));
        context.put("storeTypePath", GeneratorCodeUtils.ReplacePathHandle(storeTypePath));
        context.put("apiPath", GeneratorCodeUtils.ReplacePathHandle(apiPath));

        // 写入文件
        writeFiles(lowercaseName, lowerHyphen, context);
    }

    /**
     * * 写入文件
     *
     * @param lowercaseName 文件名称，开头小写
     * @param context       VelocityContext上下文信息
     */
    public static void writeFiles(String lowercaseName, String lowerHyphen, VelocityContext context) throws IOException {
        // 加载模板
        Template columnsTemplate = Velocity.getTemplate("vms/web/columns.vm", "UTF-8");
        Template handlerTemplate = Velocity.getTemplate("vms/web/handler.vm", "UTF-8");
        Template apiFileTemplate = Velocity.getTemplate("vms/web/fetchAPi.vm", "UTF-8");
        Template storeFileTemplate = Velocity.getTemplate("vms/web/store.vm", "UTF-8");
        Template storeTypeTemplate = Velocity.getTemplate("vms/web/storeType.vm", "UTF-8");
        Template indexTemplate = Velocity.getTemplate("vms/web/vue/index.vm", "UTF-8");
        Template dialogTemplate = Velocity.getTemplate("vms/web/vue/dialog.vm", "UTF-8");
        Template addDialogTemplate = Velocity.getTemplate("vms/web/vue/addDialog.vm", "UTF-8");
        Template dialogUpdateTemplate = Velocity.getTemplate("vms/web/vue/dialogUpdate.vm", "UTF-8");

        // 写入模板
        FileWriter columnsTemplateFileWriter = new FileWriter(columnsPath + "columns.ts");
        FileWriter handlerTemplateFileWriter = new FileWriter(columnsPath + "handler.ts");
        FileWriter apiFileTemplateFileWrite = new FileWriter(apiPath + lowercaseName + ".ts");
        FileWriter storeFileTemplateFileWriter = new FileWriter(storePath + lowercaseName + ".ts");
        FileWriter storeTypeTemplateFileWriter = new FileWriter(storeTypePath + lowercaseName + ".ts");
        FileWriter indexTemplateFileWriter = new FileWriter(vuePath + "index.vue");
        FileWriter dialogTemplateFileWriter = new FileWriter(vuePath + lowerHyphen + "-dialog.vue");
        FileWriter addDialogTemplateFileWriter = new FileWriter(vuePath + lowerHyphen + "-add.vue");
        FileWriter dialogUpdateTemplateFileWriter = new FileWriter(vuePath + lowerHyphen + "-update.vue");

        // 合并数据到模板
        dialogUpdateTemplate.merge(context, dialogUpdateTemplateFileWriter);
        addDialogTemplate.merge(context, addDialogTemplateFileWriter);
        dialogTemplate.merge(context, dialogTemplateFileWriter);
        indexTemplate.merge(context, indexTemplateFileWriter);
        columnsTemplate.merge(context, columnsTemplateFileWriter);
        handlerTemplate.merge(context, handlerTemplateFileWriter);
        apiFileTemplate.merge(context, apiFileTemplateFileWrite);
        storeFileTemplate.merge(context, storeFileTemplateFileWriter);
        storeTypeTemplate.merge(context, storeTypeTemplateFileWriter);

        // 释放资源
        columnsTemplateFileWriter.close();
        handlerTemplateFileWriter.close();
        apiFileTemplateFileWrite.close();
        storeFileTemplateFileWriter.close();
        storeTypeTemplateFileWriter.close();
        indexTemplateFileWriter.close();
        dialogTemplateFileWriter.close();
        addDialogTemplateFileWriter.close();
        dialogUpdateTemplateFileWriter.close();
    }
}
