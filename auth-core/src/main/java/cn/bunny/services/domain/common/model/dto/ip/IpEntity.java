package cn.bunny.services.domain.common.model.dto.ip;

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
@ApiModel(value = "IpEntity对象", description = "用户IP相关信息")
public class IpEntity {

    @ApiModelProperty("原始地址")
    private String ipAddr;

    @ApiModelProperty("IP归属地")
    private String ipRegion;

}
