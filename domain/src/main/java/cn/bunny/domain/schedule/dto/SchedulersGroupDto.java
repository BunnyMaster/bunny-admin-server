package cn.bunny.domain.schedule.dto;

import cn.bunny.domain.common.ValidationGroups;
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
@Schema(name = "SchedulersGroupDto对象", title = "任务调度分组分页查询", description = "任务调度分组分页查询")
public class SchedulersGroupDto {
    
    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "groupName", title = "分组名称")
    @NotBlank(message = "分组名称不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String groupName;

    @Schema(name = "description", title = "分组详情")
    private String description;

}


