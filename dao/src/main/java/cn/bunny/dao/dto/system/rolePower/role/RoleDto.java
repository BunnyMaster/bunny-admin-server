package cn.bunny.dao.dto.system.rolePower.role;

import io.swagger.v3.oas.annotations.media.Schema;
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

    @Schema(name = "roleCode", title = "角色代码")
    private String roleCode;

    @Schema(name = "description", title = "描述")
    private String description;

}

