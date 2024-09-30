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
@ApiModel(value = "BaseEntity对象", description = "生成类基础内容")
public class BaseField {
    @ApiModelProperty("字段名称")
    private String name;

    @ApiModelProperty("注释内容")
    private String annotation;

    @ApiModelProperty("TS类型")
    private String type;

    @ApiModelProperty("注释解释")
    private String description;

    @ApiModelProperty("是否必须参数")
    private Boolean require;

    @ApiModelProperty("是否必须参数消息内容")
    private String requireMessage;
}
