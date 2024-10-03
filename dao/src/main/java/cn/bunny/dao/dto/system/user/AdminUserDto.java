package cn.bunny.dao.dto.system.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "AdminUserAddDto对象", title = "用户", description = "用户管理")
public class AdminUserDto {

    @Schema(name = "username", title = "用户名")
    private String username;

    @Schema(name = "nickName", title = "昵称")
    private String nickName;

    @Schema(name = "email", title = "邮箱")
    private String email;

    @Schema(name = "phone", title = "手机号")
    private String phone;

    @Schema(name = "sex", title = "性别", description = "0:女 1:男")
    private Byte sex;

    @Schema(name = "summary", title = "个人描述")
    private String summary;

    @Schema(name = "status", title = "状态", description = "1:禁用 0:正常")
    private Boolean status;

}