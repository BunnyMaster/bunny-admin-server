package cn.bunny.domain.model.system.dto.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "RefreshTokenDto对象", title = "登录成功返回内容", description = "登录成功返回内容")
public class RefreshTokenDto {

    @Schema(name = "refreshToken", title = "请求刷新token")
    @NotBlank(message = "请求刷新token不能为空")
    private String refreshToken;

    @Schema(name = "readMeDay", title = "记住我天数")
    private long readMeDay = 1;

}