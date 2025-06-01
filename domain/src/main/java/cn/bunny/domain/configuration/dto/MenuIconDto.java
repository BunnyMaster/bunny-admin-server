package cn.bunny.domain.configuration.dto;

import cn.bunny.domain.common.ValidationGroups;
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
@Schema(name = "MenuIconDto对象", title = "系统菜单图标分页查询", description = "系统菜单图标管理")
public class MenuIconDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "iconCode", title = "icon类名")
    @NotBlank(message = "iconCode不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String iconCode;

    @Schema(name = "iconName", title = "icon 名称")
    @NotBlank(message = "icon 名称不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String iconName;

}

