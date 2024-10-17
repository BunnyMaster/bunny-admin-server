package cn.bunny.dao.dto.quartz;

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
@Schema(name = "SchedulersOperationDto对象", title = "Schedulers公共操作表单", description = "Schedulers公共操作表单")
public class SchedulersOperationDto {

    @Schema(name = "jobName", title = "任务名称")
    @NotBlank(message = "任务名称不能为空")
    @NotNull(message = "任务名称不能为空")
    private String jobName;

    @Schema(name = "jobGroup", title = "任务分组")
    @NotBlank(message = "任务分组不能为空")
    @NotNull(message = "任务分组不能为空")
    private String jobGroup;

}