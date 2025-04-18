package cn.bunny.domain.system.dto.router;

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
@Schema(name = "AssignRolesToRoutersDto对象", title = "路由分配角色", description = "路由分配角色")
public class AssignRolesToRoutersDto {

    @Schema(name = "routerId", title = "路由id")
    @NotNull(message = "路由id不能为空")
    @NotEmpty(message = "路由id不能为空")
    private List<Long> routerIds;

    @Schema(name = "roleIds", title = "角色id列表")
    @NotNull(message = "角色id列表不能为空")
    @NotEmpty(message = "角色id列表不能为空")
    private List<Long> roleIds;

}