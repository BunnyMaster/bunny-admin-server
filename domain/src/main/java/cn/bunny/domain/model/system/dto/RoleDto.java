package cn.bunny.domain.model.system.dto;

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
@Schema(name = "RoleDto对象", title = "角色分页查询", description = "角色管理")
public class RoleDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "roleCode", title = "角色代码")
    @NotBlank(message = "roleCode 不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String roleCode;

    @Schema(name = "description", title = "描述")
    @NotBlank(message = "description 不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String description;

}

