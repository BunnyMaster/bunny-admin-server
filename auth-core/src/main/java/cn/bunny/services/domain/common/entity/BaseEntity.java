package cn.bunny.services.domain.common.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@Setter
@Schema(name = "BaseEntity", title = "基础信息字段", description = "基础信息字段")
public class BaseEntity implements Serializable {

    @Schema(name = "id", title = "唯一标识")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;

    @Schema(name = "createTime", title = "创建时间")
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @Schema(name = "updateTime", title = "更新时间")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;

    @Schema(name = "createUser", title = "创建用户")
    @TableField(fill = FieldFill.INSERT)
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JsonSerialize(using = ToStringSerializer.class)
    private Long createUser;

    @Schema(name = "updateUser", title = "操作用户")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JsonSerialize(using = ToStringSerializer.class)
    private Long updateUser;

}

