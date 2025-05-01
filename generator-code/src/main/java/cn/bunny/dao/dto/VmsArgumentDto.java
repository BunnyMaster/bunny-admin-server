package cn.bunny.dao.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VmsArgumentDto {

    /* 作者名称 */
    String author = "Bunny";

    /* 包名称 */
    String packageName = "cn.bunny.services";

    /* requestMapping 名称 */
    String requestMapping = "/api";

    /* 类名称，格式为：xxx xxx_xxx */
    @NotBlank(message = "类名称不能为空")
    @NotNull(message = "类名称不能为空")
    @Pattern(regexp = "^(?:[a-z][a-z0-9_]*|[_a-z][a-z0-9_]*)$", message = "类名称不合法")
    private String className;

    /* 表名称 */
    @NotBlank(message = "表名称不能为空")
    @NotNull(message = "表名称不能为空")
    @Pattern(regexp = "^(?:[a-z][a-z0-9_]*|[_a-z][a-z0-9_]*)$", message = "表名称不合法")
    private String tableName;

    /* 时间格式  */
    private String simpleDateFormat = "yyyy-MM-dd HH:mm:ss";

    /* 去除表前缀 */
    private String tablePrefixes = "t_,sys_,qrtz_,log_";

    /* 注释内容 */
    private String comment;

    /* 路径 */
    private List<String> path;

    /* SQL 语句 */
    private String sql;
}

