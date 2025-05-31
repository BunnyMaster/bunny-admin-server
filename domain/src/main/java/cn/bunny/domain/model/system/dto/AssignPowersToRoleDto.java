package cn.bunny.domain.model.system.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "AssignPowersToRoleDto对象", title = "为角色分配权限表单", description = "为角色分配权限")
public class AssignPowersToRoleDto {

    @Schema(name = "roleIds", title = "角色id")
    @NotNull(message = "角色id不能为空")
    private Long roleId;

    @Schema(name = "powerIds", title = "权限id列表")
    private List<Long> powerIds;

}
