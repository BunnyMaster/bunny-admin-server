package cn.bunny.dao.vo.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "RefreshTokenVo 对象", title = "刷新token返回内容", description = "刷新token返回内容")
public class RefreshTokenVo {

    @Schema(name = "accessToken", title = "访问令牌")
    private String accessToken;

    @Schema(name = "refreshToken", title = "刷新token")
    private String refreshToken;

    @Schema(name = "expires", title = "过期时间")
    private String expires;
}