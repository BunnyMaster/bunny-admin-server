package cn.bunny.domain.system.dto.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "AdminUserUpdateUserinfoDto对象", title = "管理员用户修改用户信息", description = "管理员用户修改密码")
public class AdminUserUpdateUserinfoDto {

    @Schema(name = "userId", title = "用户ID")
    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @Schema(name = "password", title = "用户密码")
    @NotBlank(message = "密码不能为空")
    private String password;

    @Schema(name = "avatar", title = "用户头像")
    @NotNull(message = "用户头像不能为空")
    private MultipartFile avatar;

}
