package cn.bunny.dao.vo.menuIcon;

import cn.bunny.dao.vo.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "RouterControllerVo对象", title = "路由管理端返回对象", description = "路由管理端返回对象")
public class MenuIconVo extends BaseVo {

    @Schema(name = "iconName", title = "icon 名称")
    private String iconName;

}
