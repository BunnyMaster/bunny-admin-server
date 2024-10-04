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
@Schema(name = "UserUpdateWithAvatarDto对象", title = "管理员用户修改头像", description = "管理员用户修改头像")
public class UserUpdateWithAvatarDto {

    @Schema(name = "userId", title = "用户ID")
    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @Schema(name = "avatar", title = "用户头像")
    @NotBlank(message = "用户头像不能为空")
    @NotEmpty
    private String avatar;

}