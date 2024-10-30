package cn.bunny.dao.entity.system;

import cn.bunny.dao.common.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 部门用户关系表
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_user_dept")
@Schema(name = "UserDept对象", title = "部门用户关系表", description = "部门用户关系管理")
public class UserDept extends BaseEntity {

    @Schema(name = "userId", title = "用户id")
    private Long userId;

    @Schema(name = "deptId", title = "部门id")
    private Long deptId;

}
