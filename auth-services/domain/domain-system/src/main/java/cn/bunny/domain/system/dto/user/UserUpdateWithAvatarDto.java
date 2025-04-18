package cn.bunny.domain.system.dto.user;

import io.swagger.v3.oas.annotations.media.Schema;
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
@Schema(name = "UserUpdateWithAvatarDto对象", title = "管理员用户修改头像", description = "管理员用户修改头像")
public class UserUpdateWithAvatarDto {

    @Schema(name = "userId", title = "用户ID")
    @NotNull(message = "用户ID不能为空")
    private Long userId;

    @Schema(name = "avatar", title = "用户头像")
    @NotNull(message = "用户头像不能为空")
    private MultipartFile avatar;

}