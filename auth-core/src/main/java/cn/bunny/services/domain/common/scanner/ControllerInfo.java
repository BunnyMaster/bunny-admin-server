package cn.bunny.services.domain.common.scanner;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 控制器信息类
 */

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "ControllerInfo", title = "控制器信息类", description = "控制器信息类")
public class ControllerInfo {

    @Schema(name = "tagName", title = "标签")
    private String tagName;

    @Schema(name = "tagDescription", title = "标签详情")
    private String tagDescription;

    @Schema(name = "basePath", title = "基础请求路径，RequestMapping中的")
    private String basePath;

    @Schema(name = "methods", title = "控制器啊中所有方法")
    private List<MethodInfo> methods;

}
