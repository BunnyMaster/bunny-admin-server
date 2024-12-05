package cn.bunny.dao.dto.system.menuIcon;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MenuIconDto对象", title = "系统菜单图标分页查询", description = "系统菜单图标管理")
public class MenuIconDto {

    @Schema(name = "iconCode", title = "icon类名")
    private String iconCode;

    @Schema(name = "iconName", title = "icon 名称")
    private String iconName;

}

