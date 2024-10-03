package cn.bunny.dao.dto.menuIcon;

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
@Schema(name = "MenuIconUpdateDto对象", title = "系统菜单图标", description = "系统菜单图标管理")
public class MenuIconUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "iconName", title = "icon 名称")
    @NotBlank(message = "icon 名称不能为空")
    private String iconName;

}