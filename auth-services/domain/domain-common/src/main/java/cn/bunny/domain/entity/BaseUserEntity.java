package cn.bunny.domain.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@Schema(name = "BaseUserEntity", title = "基础信息字段包含用户信息", description = "基础信息字段包含用户信息")
public class BaseUserEntity extends BaseEntity {

    @Schema(name = "username", title = "用户名")
    private String createUsername;

    @Schema(name = "nickname", title = "昵称")
    private String updateUsername;

}
