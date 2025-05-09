package cn.bunny.services.domain.system.files.entity;

import cn.bunny.services.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_files_part_detail")
@Schema(name = "FilesParDetail对象", title = "文件分片信息表，仅在手动分片上传时使用", description = "文件分片信息表，仅在手动分片上传时使用的实体类对象")
public class FilesParDetail extends BaseEntity {

    @Schema(name = "platform", title = "存储平台")
    private String platform;

    @Schema(name = "uploadId", title = "上传ID，仅在手动分片上传时使用")
    private String uploadId;

    @Schema(name = "eTag", title = "分片 ETag")
    private String eTag;

    @Schema(name = "partNumber", title = "分片号。每一个上传的分片都有一个分片号，一般情况下取值范围是1~10000")
    private Integer partNumber;

    @Schema(name = "partSize", title = "文件大小，单位字节")
    private Long partSize;

    @Schema(name = "hashInfo", title = "哈希信息")
    private String hashInfo;

}