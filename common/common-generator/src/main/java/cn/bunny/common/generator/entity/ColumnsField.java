package cn.bunny.common.generator.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ApiModel(value = "ColumnsField对象", description = "columns列字段名称")
public class ColumnsField {
    @ApiModelProperty("列字段名称")
    private String name;

    @ApiModelProperty("列字段值")
    private String value;
}
