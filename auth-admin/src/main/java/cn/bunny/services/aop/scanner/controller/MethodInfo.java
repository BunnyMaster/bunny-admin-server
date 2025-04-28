package cn.bunny.services.aop.scanner.controller;

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
@Schema(name = "MethodInfo", title = "方法信息类", description = "控制器中方法信息类")
public class MethodInfo {

    @Schema(name = "path", title = "方法中的路径")
    private String path;

    @Schema(name = "httpMethod", title = "请求方法/方式")
    private String httpMethod;

    @Schema(name = "summary", title = "请求方法简介")
    private String summary;

    @Schema(name = "description", title = "请求方法详情")
    private String description;

    @Schema(name = "tags", title = "标签列")
    private List<String> tags;

}
