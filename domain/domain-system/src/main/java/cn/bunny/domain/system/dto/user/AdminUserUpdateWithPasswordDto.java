package cn.bunny.domain.system.dto.user;

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
public class AdminUserUpdateWithPasswordDto {

    @Schema(name = "userId", title = "用户ID")
    @NotNull(message = "用户ID不能为空")
    private Long userId;


}

