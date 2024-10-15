package cn.bunny.dao.entity.schedulers;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 任务调度分组表
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_schedulers_group")
@Schema(name = "SchedulersGroup对象", title = "任务调度分组", description = "任务调度分组")
public class SchedulersGroup extends BaseEntity {

    @Schema(name = "groupName", title = "分组名称")
    private String groupName;

    @Schema(name = "description", title = "分组详情")
    private String description;

}

