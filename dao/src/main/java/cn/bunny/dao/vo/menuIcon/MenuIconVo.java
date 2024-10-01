package cn.bunny.dao.vo.menuIcon;

import cn.bunny.dao.vo.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MenuIconVo对象", title = "系统菜单图标", description = "系统菜单图标")
public class MenuIconVo extends BaseVo {

    @Schema(name = "iconName", title = "icon 名称")
    private String iconName;

}