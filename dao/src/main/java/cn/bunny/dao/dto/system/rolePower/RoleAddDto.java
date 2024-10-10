package cn.bunny.dao.dto.system.rolePower;

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
@Schema(name = "RoleAddDto对象", title = "角色", description = "角色管理")
public class RoleAddDto {

    @Schema(name = "roleCode", title = "角色代码")
    @NotBlank(message = "roleCode 不能为空")
    @NotNull(message = "roleCode 不能为空")
    private String roleCode;

    @Schema(name = "description", title = "描述")
    @NotBlank(message = "description 不能为空")
    @NotNull(message = "description 不能为空")
    private String description;

}


