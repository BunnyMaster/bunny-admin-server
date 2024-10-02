package cn.bunny.common.generator.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "BaseResultMap对象", title = "数据库基础字段返回映射", description = "数据库基础字段返回映射")
public class BaseResultMap {

    @Schema(name = "column", title = "数据库字段")
    private String column;

    @Schema(name = "property", title = "实体类字段")
    private String property;
}
