package cn.bunny.domain.log.vo;

import cn.bunny.domain.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "QuartzExecuteLogVo对象", title = "调度任务执行日志返回对象", description = "调度任务执行日志返回对象")
public class QuartzExecuteLogVo extends BaseUserVo {

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

}
