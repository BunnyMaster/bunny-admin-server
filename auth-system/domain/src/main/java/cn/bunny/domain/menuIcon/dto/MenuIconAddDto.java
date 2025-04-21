package cn.bunny.domain.menuIcon.dto;

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
@Schema(name = "MenuIconAddDto对象", title = "添加系统菜单图标", description = "添加系统菜单图标")
public class MenuIconAddDto {

    @Schema(name = "iconCode", title = "icon类名")
    @NotBlank(message = "iconCode不能为空")
    @NotNull(message = "iconCode不能为空")
    private String iconCode;

    @Schema(name = "iconName", title = "icon 名称")
    @NotBlank(message = "icon 名称不能为空")
    @NotNull(message = "icon 名称不能为空")
    private String iconName;

}

