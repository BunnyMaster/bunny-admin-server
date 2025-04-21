package cn.bunny.domain.system.dto.user;

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
@Schema(name = "AdminUserUpdateDto对象", title = "更新用户", description = "用户管理")
public class AdminUserUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "username", title = "用户名")
    @NotBlank(message = "用户名不能为空")
    @NotNull(message = "用户名不能为空")
    private String username;

    @Schema(name = "nickname", title = "昵称")
    @NotBlank(message = "昵称不能为空")
    @NotNull(message = "昵称不能为空")
    private String nickname;

    @Schema(name = "email", title = "邮箱")
    @NotBlank(message = "邮箱不能为空")
    @NotNull(message = "邮箱不能为空")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "sex", title = "性别", description = "0:女 1:男")
    private Byte sex;

    @Schema(name = "summary", title = "个人描述")
    private String summary;

    @Schema(name = "deptId", title = "部门")
    @NotNull(message = "部门不能为空")
    private Long deptId;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Boolean status;

}

