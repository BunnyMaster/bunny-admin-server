package cn.bunny.services.domain.system.quartz.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * <p>
 * VIEW
 * </p>
 *
 * @author Bunny
 * @since 2024-10-14
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("view_qrtz_schedulers")
@Schema(name = "Schedulers对象", title = "Schedulers视图", description = "Schedulers视图")
public class Schedulers implements Serializable {

    @Schema(name = "jobName", title = "任务名称")
    @TableId(type = IdType.NONE)
    private String jobName;

    @Schema(name = "jobGroup", title = "任务分组")
    private String jobGroup;

    @Schema(name = "description", title = "任务详情")
    private String description;

    @Schema(name = "jobClassName", title = "任务类名称")
    private String jobClassName;

    @Schema(name = "cronExpression", title = "corn表达式")
    private String cronExpression;

    @Schema(name = "triggerName", title = "触发器名称")
    private String triggerName;

    @Schema(name = "triggerState", title = "triggerState触发器状态")
    private String triggerState;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;

}