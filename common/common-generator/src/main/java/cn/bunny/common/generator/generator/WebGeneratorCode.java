package cn.bunny.common.generator.generator;

import cn.bunny.common.generator.entity.BaseField;
import cn.bunny.common.generator.utils.GeneratorCodeUtils;
import cn.bunny.dao.dto.menuIcon.MenuIconAddDto;
import cn.bunny.dao.dto.menuIcon.MenuIconDto;
import cn.bunny.dao.dto.menuIcon.MenuIconUpdateDto;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.vo.menuIcon.MenuIconVo;
import com.google.common.base.CaseFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Field;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

/**
 * * 代码生成器入口点
 */
@Service
public class WebGeneratorCode {
    // 公共路径
    public static String commonPath = "D:\\Project\\web\\PC\\auth\\auth-web\\src";
    // 生成API请求路径
    public static String apiPath = commonPath + "\\api\\v1\\";
    // 生成vue路径
    public static String vuePath = commonPath + "\\views\\system\\";
    // 生成仓库路径
    public static String storePath = commonPath + "\\store\\modules";
    // 后端controller
    public static String controllerPath = "D:\\Project\\web\\PC\\auth\\auth-server-java\\service\\src\\main\\java\\cn\\bunny\\services\\controller\\";
    public static String servicePath = "D:\\Project\\web\\PC\\auth\\auth-server-java\\service\\src\\main\\java\\cn\\bunny\\services\\service\\";
    public static String serviceImplPath = "D:\\Project\\web\\PC\\auth\\auth-server-java\\service\\src\\main\\java\\cn\\bunny\\services\\service\\impl\\";
    public static String mapperPath = "D:\\Project\\web\\PC\\auth\\auth-server-java\\service\\src\\main\\java\\cn\\bunny\\services\\mapper\\";
    public static String resourceMapperPath = "D:\\Project\\web\\PC\\auth\\auth-server-java\\service\\src\\main\\resources\\mapper\\";

    public static void main(String[] args) throws Exception {
        Class<MenuIcon> originalClass = MenuIcon.class;
        Class<MenuIconDto> dtoClass = MenuIconDto.class;
        Class<MenuIconAddDto> addDtoClass = MenuIconAddDto.class;
        Class<MenuIconUpdateDto> updateDtoClass = MenuIconUpdateDto.class;
        Class<MenuIconVo> voClass = MenuIconVo.class;

        // 设置velocity资源加载器
        Properties prop = new Properties();
        prop.put("file.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");
        Velocity.init(prop);
        // 创建Velocity容器
        VelocityContext context = new VelocityContext();

        // 原始类名称
        String originalName = originalClass.getSimpleName();
        // 转成开头小写类名称，作为文件名
        String lowercaseName = originalName.substring(0, 1).toLowerCase() + originalName.substring(1);
        // 转成中划线，做vue命名使用
        String lowerHyphen = CaseFormat.LOWER_CAMEL.to(CaseFormat.LOWER_HYPHEN, originalName);
        // 生成字段xxx管理
        String classDescription = originalClass.getAnnotation(Schema.class).description();
        // 类注解标题
        String classTitle = originalClass.getAnnotation(Schema.class).title();

        context.put("originalName", originalName);
        context.put("lowercaseName", lowercaseName);
        context.put("lowerHyphen", lowerHyphen);
        context.put("classDescription", classDescription);
        context.put("classTitle", classTitle);
        context.put("leftBrace", "${");
        context.put("date", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

        generatorWebCode(dtoClass, addDtoClass, context);

        // 写入文件
        writeFiles(lowercaseName, lowerHyphen, originalName, context);
    }

    public static void generatorWebCode(Class<?> dtoClass, Class<?> addDtoClass, VelocityContext context) {
        // 生成 Store 中 form 表单内容
        List<BaseField> formList = Arrays.stream(dtoClass.getDeclaredFields())
                .filter(field -> !field.getName().equals("id"))
                .map(field -> BaseField.builder().name(field.getName()).annotation(field.getAnnotation(Schema.class).title()).build())
                .toList();

        // 添加表单字段值
        List<String> addFormList = Arrays.stream(addDtoClass.getDeclaredFields()).map(Field::getName).toList();

        // 是否必须字段设置
        List<BaseField> baseFieldList = Arrays.stream(addDtoClass.getDeclaredFields()).map(field -> {
            try {
                // 验证消息
                String message = field.getAnnotation(NotBlank.class).message();
                boolean hasMessage = StringUtils.hasText(message);
                if (!hasMessage) message = field.getAnnotation(NotNull.class).message();

                // 设置基础字段注解和是否必填项
                BaseField baseField = new BaseField();
                baseField.setName(field.getName());
                baseField.setType(baseField.getType());
                baseField.setAnnotation(field.getAnnotation(Schema.class).title());
                baseField.setType(GeneratorCodeUtils.convertJavaTypeToTypeScript(field.getType()));
                baseField.setRequire(hasMessage);
                if (hasMessage) baseField.setRequireMessage(message);

                return baseField;
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }).toList();

        // 生成查询表单字段
        context.put("formList", formList);
        context.put("addFormList", addFormList);
        context.put("baseFieldList", baseFieldList);
    }

    public static void writeFiles(String lowercaseName, String lowerHyphen, String originalName, VelocityContext context) throws IOException {
        context.put("apiPath", GeneratorCodeUtils.ReplacePathHandle(apiPath) + lowercaseName);
        context.put("typesPath", GeneratorCodeUtils.ReplacePathHandle(vuePath) + lowercaseName + "/utils/types");
        context.put("hookPath", GeneratorCodeUtils.ReplacePathHandle(vuePath) + lowercaseName + "/utils/hook");
        context.put("columnsPath", GeneratorCodeUtils.ReplacePathHandle(vuePath) + lowercaseName + "/utils/columns");
        context.put("dialogPath", GeneratorCodeUtils.ReplacePathHandle(vuePath) + lowercaseName + "/" + lowerHyphen + "-dialog.vue");

        // 写入api模板
        Template apiTemplate = Velocity.getTemplate("vms/web/api.vm", "UTF-8");
        FileWriter apiTemplateFileWriter = new FileWriter(apiPath + lowercaseName + ".ts");
        apiTemplate.merge(context, apiTemplateFileWriter);
        apiTemplateFileWriter.close();

        // 写入弹窗模板
        Template dialogTemplate = Velocity.getTemplate("vms/web/dialog.vm", "UTF-8");
        FileWriter dialogTemplateFileWriter = new FileWriter(vuePath + lowercaseName + "\\" + lowerHyphen + "-dialog.vue");
        dialogTemplate.merge(context, dialogTemplateFileWriter);
        dialogTemplateFileWriter.close();

        // 写入hook模板
        Template hookTemplate = Velocity.getTemplate("vms/web/hook.vm", "UTF-8");
        FileWriter hookTemplateFileWriter = new FileWriter(vuePath + lowercaseName + "\\utils\\hook.ts");
        hookTemplate.merge(context, hookTemplateFileWriter);
        hookTemplateFileWriter.close();

        // 写入hook模板
        Template storeTemplate = Velocity.getTemplate("vms/web/store.vm", "UTF-8");
        FileWriter storeTemplateFileWriter = new FileWriter(storePath + "\\" + lowercaseName + ".ts");
        storeTemplate.merge(context, storeTemplateFileWriter);
        storeTemplateFileWriter.close();

        // 写入types模板
        Template typesTemplate = Velocity.getTemplate("vms/web/types.vm", "UTF-8");
        FileWriter typesTemplateFileWriter = new FileWriter(vuePath + lowercaseName + "\\utils\\types.ts");
        typesTemplate.merge(context, typesTemplateFileWriter);
        typesTemplateFileWriter.close();

        // 写入index模板
        Template indexTemplate = Velocity.getTemplate("vms/web/index.vm", "UTF-8");
        FileWriter indexTemplateFileWriter = new FileWriter(vuePath + lowercaseName + "\\index.vue");
        indexTemplate.merge(context, indexTemplateFileWriter);
        indexTemplateFileWriter.close();

        // 写入columns模板
        Template columnsTemplate = Velocity.getTemplate("vms/web/columns.vm", "UTF-8");
        FileWriter columnsTemplateFileWriter = new FileWriter(vuePath + lowercaseName + "\\utils\\columns.ts");
        columnsTemplate.merge(context, columnsTemplateFileWriter);
        columnsTemplateFileWriter.close();

        // 写入controller模板
        Template controllerTemplate = Velocity.getTemplate("vms/server/controller.vm", "UTF-8");
        FileWriter controllerTemplateFileWriter = new FileWriter(controllerPath + originalName + "Controller.java");
        controllerTemplate.merge(context, controllerTemplateFileWriter);
        controllerTemplateFileWriter.close();

        // 写入servicePath模板
        Template servicePathTemplate = Velocity.getTemplate("vms/server/service.vm", "UTF-8");
        FileWriter servicePathTemplateFileWriter = new FileWriter(servicePath + originalName + "Service.java");
        servicePathTemplate.merge(context, servicePathTemplateFileWriter);
        servicePathTemplateFileWriter.close();

        // 写入serviceImplPath模板
        Template serviceImplPathTemplate = Velocity.getTemplate("vms/server/serviceImpl.vm", "UTF-8");
        FileWriter serviceImplPathTemplateFileWriter = new FileWriter(serviceImplPath + originalName + "ServiceImpl.java");
        serviceImplPathTemplate.merge(context, serviceImplPathTemplateFileWriter);
        serviceImplPathTemplateFileWriter.close();

        // 写入serviceImplPath模板
        Template mapperPathTemplate = Velocity.getTemplate("vms/server/mapper.vm", "UTF-8");
        FileWriter mapperPathTemplateFileWriter = new FileWriter(mapperPath + originalName + "Mapper.java");
        mapperPathTemplate.merge(context, mapperPathTemplateFileWriter);
        mapperPathTemplateFileWriter.close();

        // 写入resourceMapperPath模板
        Template resourceMapperPathTemplate = Velocity.getTemplate("vms/server/resourceMapper.vm", "UTF-8");
        FileWriter resourceMapperPathTemplateFileWriter = new FileWriter(mapperPath + originalName + "Mapper.xml");
        resourceMapperPathTemplate.merge(context, resourceMapperPathTemplateFileWriter);
        resourceMapperPathTemplateFileWriter.close();
    }
}
