package cn.bunny.services.domain.system.log.entity;

import cn.bunny.services.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 调度任务执行日志
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("log_quartz_execute")
@Schema(name = "QuartzExecuteLog对象", title = "调度任务执行日志", description = "调度任务执行日志")
public class ScheduleExecuteLog extends BaseEntity {

    @Schema(name = "jobName", title = "任务名称")
    private String jobName;

    @Schema(name = "jobGroup", title = "任务分组")
    private String jobGroup;

    @Schema(name = "jobClassName", title = "执行任务类名")
    private String jobClassName;

    @Schema(name = "cronExpression", title = "执行任务core表达式")
    private String cronExpression;

    @Schema(name = "triggerName", title = "触发器名称")
    private String triggerName;

    @Schema(name = "executeResult", title = "执行结果")
    private String executeResult;

    @Schema(name = "duration", title = "执行时间")
    private Long duration;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;
}


