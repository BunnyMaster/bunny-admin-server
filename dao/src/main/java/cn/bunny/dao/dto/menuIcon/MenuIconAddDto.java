package cn.bunny.dao.dto.menuIcon;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MenuIconAddDto对象", title = "系统菜单图标", description = "系统菜单图标管理")
public class MenuIconAddDto {

    @Schema(name = "iconName", title = "icon 名称")
    @NotBlank(message = "icon 名称不能为空")
    private String iconName;

}

