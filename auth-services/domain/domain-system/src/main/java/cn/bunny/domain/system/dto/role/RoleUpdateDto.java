package cn.bunny.domain.system.dto.role;

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
@Schema(name = "RoleUpdateDto对象", title = "更新角色", description = "角色管理")
public class RoleUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "roleCode", title = "角色代码")
    @NotBlank(message = "roleCode 不能为空")
    @NotNull(message = "roleCode 不能为空")
    private String roleCode;

    @Schema(name = "description", title = "描述")
    @NotBlank(message = "description 不能为空")
    @NotNull(message = "description 不能为空")
    private String description;

}