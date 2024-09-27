package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
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
@ApiModel(value = "SystemLog对象", description = "系统日志表")
public class SystemLog extends BaseEntity {

    @ApiModelProperty("所在类路径")
    private String classPath;

    @ApiModelProperty("执行方法名称")
    private String methodName;

    @ApiModelProperty("入参内容")
    private String args;

    @ApiModelProperty("返回参数")
    private String result;

    @ApiModelProperty("报错堆栈")
    private String errorStack;

    @ApiModelProperty("报错")
    private String errorMessage;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("用户名")
    private String nickname;

    @ApiModelProperty("当前用户token")
    private String token;

    @ApiModelProperty("当前用户IP地址")
    private String ipAddress;

}