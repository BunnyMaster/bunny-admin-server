package cn.bunny.common.generator.generator;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import org.apache.ibatis.annotations.Mapper;

import java.util.Collections;

public class AdminCodeGenerator {
    // 数据连接
    public static final String sqlHost = "jdbc:mysql://192.168.3.98:3304/auth_admin?serverTimezone=GMT%2B8&useSSL=false&characterEncoding=utf-8&allowPublicKeyRetrieval=true";
    // 作者名称
    public static final String author = "Bunny";
    // 公共路径
    // public static final String outputDir = "D:\\MyFolder\\Bunny\\BunnyBBS\\BunnyBBS-server-admin\\service";
    public static final String outputDir = "D:\\Project\\web\\PC\\auth\\auth-server-java\\service";
    // 实体类名称
    public static final String entity = "Bunny";

    public static void main(String[] args) {
        Generation("sys_dept", "sys_user_dept");
    }

    /**
     * 根据表名生成相应结构代码
     *
     * @param tableName 表名
     */
    public static void Generation(String... tableName) {
        // 修改数据库路径、账户、密码
        FastAutoGenerator.create(sqlHost, "root", "02120212")
                .globalConfig(builder -> {
                    // 添加作者名称
                    builder.author(author)
                            // 启用swagger
                            .enableSwagger()
                            // 指定输出目录
                            .outputDir(outputDir + "/src/main/java");
                })
                .packageConfig(builder -> builder.entity(entity)// 实体类包名
                        // 父包名。如果为空，将下面子包名必须写全部， 否则就只需写子包名
                        .parent("cn.bunny.services")
                        .controller("controller")// 控制层包名
                        .mapper("mapper")// mapper层包名
                        .service("service")// service层包名
                        .serviceImpl("service·impl")// service实现类包名
                        // 自定义mapper.xml文件输出目录
                        .pathInfo(Collections.singletonMap(OutputFile.xml, outputDir + "/src/main/resources/mapper")))
                .strategyConfig(builder -> {
                    // 设置要生成的表名
                    builder.addInclude(tableName)
                            .addTablePrefix("sys_")
                            .entityBuilder()
                            .enableLombok()
                            .enableChainModel()
                            .naming(NamingStrategy.underline_to_camel)// 数据表映射实体命名策略：默认下划线转驼峰underline_to_camel
                            .columnNaming(NamingStrategy.underline_to_camel)// 表字段映射实体属性命名规则：默认null，不指定按照naming执行
                            .idType(IdType.AUTO)// 添加全局主键类型
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
                .execute();
    }
}
