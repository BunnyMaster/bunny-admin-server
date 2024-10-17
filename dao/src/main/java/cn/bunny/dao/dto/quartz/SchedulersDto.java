package cn.bunny.dao.dto.quartz;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "SchedulersDto对象", title = "Schedulers查询表单", description = "Schedulers查询表单")
public class SchedulersDto {

    @Schema(name = "jobName", title = "任务名称")
    private String jobName;

    @Schema(name = "jobGroup", title = "任务分组")
    private String jobGroup;

    @Schema(name = "description", title = "任务详情")
    private String description;

    @Schema(name = "jobClassName", title = "任务类名称")
    @NotNull(message = "corn表达式不能为空")
    private String jobClassName;

    @Schema(name = "triggerName", title = "触发器名称")
    private String triggerName;

    @Schema(name = "triggerState", title = "triggerState触发器状态")
    private String triggerState;

    @Schema(name = "jobMethodName", title = "执行方法")
    private String jobMethodName;

}

