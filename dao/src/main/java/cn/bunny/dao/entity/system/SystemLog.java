package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 系统日志表
 * </p>
 *
 * @author Bunny
 * @since 2024-05-31
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("system_log")
@Schema(name = "SystemLog对象", title = "系统日志表", description = "系统日志表")
public class SystemLog extends BaseEntity {

    @Schema(name = "classPath", title = "所在类路径")
    private String classPath;

    @Schema(name = "methodName", title = "执行方法名称")
    private String methodName;

    @Schema(name = "args", title = "入参内容")
    private String args;

    @Schema(name = "result", title = "返回参数")
    private String result;

    @Schema(name = "errorStack", title = "报错堆栈")
    private String errorStack;

    @Schema(name = "errorMessage", title = "报错")
    private String errorMessage;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "nickname", title = "用户名")
    private String nickname;

    @Schema(name = "token", title = "当前用户token")
    private String token;

    @Schema(name = "ipAddress", title = "当前用户IP地址")
    private String ipAddress;

}