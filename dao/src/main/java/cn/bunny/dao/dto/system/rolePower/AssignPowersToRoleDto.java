package cn.bunny.dao.dto.system.rolePower;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
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
    @NotNull(message = "权限id列表不能为空")
    @NotEmpty(message = "权限id列表不能为空")
    private List<Long> powerIds;

}
