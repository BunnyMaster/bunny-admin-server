package cn.bunny.domain.common.model.dto.scanner;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "MenuIconVo对象", title = "系统菜单图标", description = "系统菜单图标")
public class ScannerControllerInfoVo {

    @Schema(name = "httpMethod", title = "标签")
    private String httpMethod;

    @Schema(name = "path", title = "路径")
    private String path;

    @Schema(name = "summary", title = "简介")
    private String summary;

    @Schema(name = "description", title = "详情")
    private String description;

    @Schema(name = "powerCode", title = "权限码")
    private String powerCode;

    @Schema(name = "description", title = "标签")
    private List<ScannerControllerInfoVo> children;

}
