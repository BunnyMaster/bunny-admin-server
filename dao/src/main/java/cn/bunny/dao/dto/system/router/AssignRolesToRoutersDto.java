package cn.bunny.dao.dto.system.router;

import io.swagger.v3.oas.annotations.media.Schema;
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
    private Long routerId;

    @Schema(name = "roleIds", title = "角色id列表")
    private List<Long> roleIds;

}