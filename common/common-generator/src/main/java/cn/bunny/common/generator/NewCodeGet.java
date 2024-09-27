package cn.bunny.common.generator;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collections;

public class NewCodeGet {
    // 数据连接
    public static final String sqlHost = "jdbc:mysql://106.15.251.123:3305/bunny_docs?serverTimezone=GMT%2B8&useSSL=false&characterEncoding=utf-8&allowPublicKeyRetrieval=true";
    // 作者名称
    public static final String author = "Bunny";
    // 公共路径
    public static final String outputDir = "F:\\web项目\\PC\\BunnyNote\\BunnyBBS-server\\service\\service-web";
    // 实体类名称
    public static final String entity = "Bunny";

    public static void main(String[] args) {
        Generation("article");
    }

    /**
     * 根据表名生成相应结构代码
     *
     * @param tableName 表名
     */
    public static void Generation(String... tableName) {
        // TODO 修改数据库路径、账户、密码
        FastAutoGenerator.create(sqlHost, "root", "02120212")
                .globalConfig(builder -> {
                    // 添加作者名称
                    builder.author(author)
                            // 启用swagger
                            .enableSwagger()
                            // 指定输出目录
                            .outputDir(outputDir + "/src/main/java");
                })
                .packageConfig(builder -> {
                    builder.entity(entity)// 实体类包名
                            // TODO 父包名。如果为空，将下面子包名必须写全部， 否则就只需写子包名
                            .parent("cn.bunny.service.web")
                            .controller("controller")// 控制层包名
                            .mapper("mapper")// mapper层包名
                            .service("service")// service层包名
                            .serviceImpl("service.impl")// service实现类包名
                            // 自定义mapper.xml文件输出目录
                            .pathInfo(Collections.singletonMap(OutputFile.xml, outputDir + "/src/main/resources/mapper"));
                })
                .strategyConfig(builder -> {
                    // 设置要生成的表名
                    builder.addInclude(tableName)
                            //.addTablePrefix("sys_")// TODO 设置表前缀过滤
                            .entityBuilder()
                            .enableLombok()
                            .enableChainModel()
                            .naming(NamingStrategy.underline_to_camel)// 数据表映射实体命名策略：默认下划线转驼峰underline_to_camel
                            .columnNaming(NamingStrategy.underline_to_camel)// 表字段映射实体属性命名规则：默认null，不指定按照naming执行
                            .idType(IdType.AUTO)// TODO 添加全局主键类型
                            .formatFileName("%s")// 格式化实体名称，%s取消首字母I,
                            .mapperBuilder()
                            .mapperAnnotation(Mapper.class)// 开启mapper注解
                            .enableBaseResultMap()// 启用xml文件中的BaseResultMap 生成
                            .enableBaseColumnList()// 启用xml文件中的BaseColumnList
                            .formatMapperFileName("%sMapper")// 格式化Dao类名称
                            .formatXmlFileName("%sMapper")// 格式化xml文件名称
                            .serviceBuilder()
                            .formatServiceFileName("%sService")// 格式化 service 接口文件名称
                            .formatServiceImplFileName("%sServiceImpl")// 格式化 service 接口文件名称
                            .controllerBuilder()
                            .enableRestStyle();
                })
                // .injectionConfig(consumer -> {
                //     Map<String, String> customFile = new HashMap<>();
                //     // 配置DTO（需要的话）但是需要有能配置Dto的模板引擎，比如freemarker，但是这里我们用的VelocityEngine，因此不多作介绍
                //     customFile.put(outputDir, "/src/main/resources/templates/entityDTO.java.ftl");
                //     consumer.customFile(customFile);
                // })
                .execute();
    }
}
