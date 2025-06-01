package cn.bunny.domain.system.entity.router;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(name = "RouterMetaTransition对象", title = "系统菜单动画属性", description = "系统菜单动画属性")
public class RouterMetaTransition {

    @Schema(name = "enterTransition", title = "入场动画")
    private String enterTransition;

    @Schema(name = "leaveTransition", title = "离场动画")
    private String leaveTransition;

}