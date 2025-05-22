package cn.bunny.services.domain.configuration.vo;

import cn.bunny.services.domain.common.model.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MenuIconVo对象", title = "系统菜单图标", description = "系统菜单图标")
public class MenuIconVo extends BaseUserVo {

    @Schema(name = "iconCode", title = "icon类名")
    private String iconCode;

    @Schema(name = "iconName", title = "icon 名称")
    private String iconName;

}