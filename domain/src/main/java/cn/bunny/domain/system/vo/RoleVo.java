package cn.bunny.domain.system.vo;

import cn.bunny.domain.common.model.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "RoleVo对象", title = "角色", description = "角色管理")
public class RoleVo extends BaseUserVo {

    @Schema(name = "roleCode", title = "角色代码")
    private String roleCode;

    @Schema(name = "description", title = "描述")
    private String description;

}


