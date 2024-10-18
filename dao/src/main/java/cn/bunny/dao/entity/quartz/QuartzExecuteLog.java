package cn.bunny.dao.entity.quartz;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

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
@TableName("quartz_execute_log")
@Schema(name = "QuartzExecuteLog对象", title = "调度任务执行日志", description = "调度任务执行日志")
public class QuartzExecuteLog extends BaseEntity {

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
    private Integer duration;

    @Schema(name = "endTime", title = "结束时间")
    private LocalDateTime endTime;

}


