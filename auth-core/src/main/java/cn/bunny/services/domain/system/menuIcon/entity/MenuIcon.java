package cn.bunny.services.domain.system.menuIcon.entity;

import cn.bunny.services.domain.common.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@EqualsAndHashCode(callSuper = true)
@Data
@Accessors(chain = true)
@TableName("sys_menu_icon")
@Schema(name = "MenuIcon对象", title = "系统菜单图标", description = "系统菜单图标")
public class MenuIcon extends BaseEntity {

    @Schema(name = "iconCode", title = "icon类名")
    private String iconCode;

    @Schema(name = "iconName", title = "icon 名称")
    private String iconName;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;

}

