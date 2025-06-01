package cn.bunny.domain.common.model.dto.ip;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "IpEntity对象", title = "用户IP相关信息")
public class IpEntity {

    @Schema(name = "ipAddr", title = "原始地址")
    private String ipAddr;

    @Schema(name = "ipRegion", title = "IP归属地")
    private String ipRegion;

}
