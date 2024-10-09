package cn.bunny.dao.dto.system.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "UserUpdateWithPasswordDto对象", title = "管理员用户修改密码", description = "管理员用户修改密码")
public class AdminUserUpdateUserStatusDto {

    @Schema(name = "userId", title = "用户ID")
    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @Schema(name = "status", title = "用户状态")
    @NotNull(message = "用户状态不能为空")
    private Boolean status;

}
