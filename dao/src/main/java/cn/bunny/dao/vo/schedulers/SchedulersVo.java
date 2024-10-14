package cn.bunny.dao.vo.schedulers;

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
@Schema(name = "SchedulersVo对象", title = "Schedulers返回内容", description = "Schedulers返回内容")
public class SchedulersVo {

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

}