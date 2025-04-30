package cn.bunny.services.domain.common.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(name = "BaseVo", title = "基础返回对象内容包含用户信息", description = "基础返回对象内容包含用户信息")
public class BaseUserVo extends BaseVo {

    @Schema(name = "username", title = "用户名")
    private String createUsername;

    @Schema(name = "nickname", title = "昵称")
    private String updateUsername;

}
