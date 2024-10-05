package cn.bunny.dao.dto.system.user;

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
@Schema(name = "AssignRolesToUsersDto对象", title = "用户分配角色", description = "用户分配角色")
public class AssignRolesToUsersDto {

    @Schema(name = "userId", title = "用户id")
    private Long userId;

    @Schema(name = "roleIds", title = "角色id列表")
    private List<Long> roleIds;

}

