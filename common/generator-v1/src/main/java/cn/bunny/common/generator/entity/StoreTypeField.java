package cn.bunny.common.generator.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ApiModel(value = "StoreTypeField对象", description = "仓库类型生成内容")
public class StoreTypeField {

    private List<BaseField> baseFieldList;

    @ApiModelProperty("接口名称")
    private String interfaceName;

    @ApiModelProperty("接口注释内容")
    private String interfaceAnnotation;
}