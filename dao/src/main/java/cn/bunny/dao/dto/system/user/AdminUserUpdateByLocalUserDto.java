package cn.bunny.dao.dto.system.user;

import cn.bunny.dao.pojo.constant.UserConstant;
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
@Schema(name = "AdminUserUpdateByLocalUserDto对象", title = "更新本地用户信息", description = "更新本地用户信息")
public class AdminUserUpdateByLocalUserDto {

    @Schema(name = "username", title = "用户名")
    @NotBlank(message = "用户名不能为空")
    @NotNull(message = "用户名不能为空")
    private String username;

    @Schema(name = "nickName", title = "昵称")
    @NotBlank(message = "昵称不能为空")
    @NotNull(message = "昵称不能为空")
    private String nickName;

    @Schema(name = "email", title = "邮箱")
    @NotBlank(message = "邮箱不能为空")
    @NotNull(message = "邮箱不能为空")
    private String email;

    @Schema(name = "avatar", title = "头像")
    private String avatar = UserConstant.USER_AVATAR;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "sex", title = "性别", description = "0:女 1:男")
    private Byte sex = 1;

    @Schema(name = "summary", title = "个人描述")
    private String summary = UserConstant.PERSON_DESCRIPTION;

}