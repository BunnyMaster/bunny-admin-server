package cn.bunny.dao.dto.system.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
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
public class UserUpdateWithPasswordDto {

    @Schema(name = "userId", title = "用户ID")
    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @Schema(name = "password", title = "用户密码")
    @NotBlank(message = "密码不能为空")
    @NotEmpty
    private String password;

}
