package cn.bunny.dao.dto.quartz.scheduleGroup;

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
@Schema(name = "SchedulersGroupUpdateDto对象", title = "更新任务调度分组", description = "更新任务调度分组")
public class SchedulersGroupUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "groupName", title = "分组名称")
    @NotBlank(message = "分组名称不能为空")
    @NotNull(message = "分组名称不能为空")
    private String groupName;

    @Schema(name = "description", title = "分组详情")
    private String description;

}