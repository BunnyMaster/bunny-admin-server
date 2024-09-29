package cn.bunny.dao.vo.router;

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
@ApiModel(value = "RouterTransition对象", description = "路由动画")
public class RouterTransition {

    @ApiModelProperty("进入动画")
    private String enterTransition;

    @ApiModelProperty("退出动画")
    private String leaveTransition;
    
}
