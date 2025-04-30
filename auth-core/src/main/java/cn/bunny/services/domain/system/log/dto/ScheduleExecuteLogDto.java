package cn.bunny.services.domain.system.log.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "QuartzExecuteLogDto对象", title = "调度任务执行日志分页查询", description = "调度任务执行日志分页查询")
public class ScheduleExecuteLogDto {

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

}
