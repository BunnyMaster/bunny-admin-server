package cn.bunny.dao.dto.schedulers;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "SchedulersAddDto对象", title = "Schedulers添加表单", description = "Schedulers添加表单")
public class SchedulersAddDto {

    @Schema(name = "jobName", title = "任务名称")
    @NotBlank(message = "任务名称不能为空")
    @NotNull(message = "任务名称不能为空")
    private String jobName;

    @Schema(name = "jobGroup", title = "任务分组")
    @NotBlank(message = "任务分组不能为空")
    @NotNull(message = "任务分组不能为空")
    private String jobGroup;

    @Schema(name = "description", title = "任务详情")
    @NotBlank(message = "任务详情不能为空")
    @NotNull(message = "任务详情不能为空")
    private String description;

    @Schema(name = "jobClassName", title = "任务类名称")
    @NotBlank(message = "corn表达式不能为空")
    @NotNull(message = "corn表达式不能为空")
    private String jobClassName;

    @Schema(name = "cronExpression", title = "corn表达式")
    @NotBlank(message = "corn表达式不能为空")
    @NotNull(message = "corn表达式不能为空")
    private String cronExpression;

}



