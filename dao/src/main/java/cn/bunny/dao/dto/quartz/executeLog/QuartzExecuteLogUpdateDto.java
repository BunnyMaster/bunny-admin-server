package cn.bunny.dao.dto.quartz.executeLog;

import cn.bunny.dao.entity.quartz.QuartzExecuteLogJson;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "QuartzExecuteLogUpdateDto对象", title = "更新调度任务执行日志", description = "更新调度任务执行日志")
public class QuartzExecuteLogUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "jobName", title = "任务名称")
    @NotBlank(message = "任务分组不能为空")
    @NotNull(message = "任务分组不能为空")
    private String jobName;

    @Schema(name = "jobGroup", title = "任务分组")
    @NotBlank(message = "任务分组不能为空")
    @NotNull(message = "任务分组不能为空")
    private String jobGroup;

    @Schema(name = "jobClassName", title = "执行任务类名")
    @NotBlank(message = "任务分组不能为空")
    @NotNull(message = "任务分组不能为空")
    private String jobClassName;

    @Schema(name = "cronExpression", title = "执行任务core表达式")
    @NotBlank(message = "任务分组不能为空")
    @NotNull(message = "任务分组不能为空")
    private String cronExpression;

    @Schema(name = "triggerName", title = "触发器名称")
    @NotBlank(message = "任务分组不能为空")
    @NotNull(message = "任务分组不能为空")
    private String triggerName;

    @Schema(name = "executeResult", title = "执行结果")
    private QuartzExecuteLogJson executeResult;

    @Schema(name = "duration", title = "执行时间")
    private Integer duration;

    @Schema(name = "endTime", title = "结束时间")
    private LocalDateTime endTime;

}