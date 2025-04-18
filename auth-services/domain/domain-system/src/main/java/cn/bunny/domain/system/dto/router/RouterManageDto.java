package cn.bunny.domain.system.dto.router;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "RouterManageDto对象", title = "路由分页查询", description = "路由分页查询")
public class RouterManageDto {

    @Schema(name = "title", title = "路由标题")
    private String title;

    @Schema(name = "visible", title = "是否显示")
    private Boolean visible;
}
