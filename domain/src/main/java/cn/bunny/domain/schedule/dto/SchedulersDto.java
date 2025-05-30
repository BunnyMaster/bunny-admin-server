package cn.bunny.domain.schedule.dto;

import cn.bunny.domain.common.ValidationGroups;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "SchedulersDto对象", title = "Schedulers分页查询", description = "Schedulers分页查询")
public class SchedulersDto {

    @Schema(name = "jobName", title = "任务名称")
    @NotBlank(message = "任务名称不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String jobName;

    @Schema(name = "jobGroup", title = "任务分组")
    @NotBlank(message = "任务分组不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String jobGroup;

    @Schema(name = "description", title = "任务详情")
    @NotBlank(message = "任务详情不能为空", groups = {ValidationGroups.Update.class})
    private String description;

    @Schema(name = "jobClassName", title = "任务类名称")
    @NotBlank(message = "corn表达式不能为空", groups = {ValidationGroups.Add.class})
    private String jobClassName;

    @Schema(name = "cronExpression", title = "corn表达式")
    @NotBlank(message = "corn表达式不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String cronExpression;


    @Schema(name = "triggerName", title = "触发器名称")
    private String triggerName;

    @Schema(name = "triggerState", title = "triggerState触发器状态")
    private String triggerState;

    @Schema(name = "jobMethodName", title = "执行方法")
    private String jobMethodName;

}

