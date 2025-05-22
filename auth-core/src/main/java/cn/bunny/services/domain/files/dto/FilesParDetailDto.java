package cn.bunny.services.domain.files.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FilesParDetailDTO对象", title = "文件分片信息表，仅在手动分片上传时使用", description = "文件分片信息表，仅在手动分片上传时使用的DTO对象")
public class FilesParDetailDto {

    @Schema(name = "id", title = "分片id")
    private String id;

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

    @Schema(name = "createUser", title = "创建用户")
    private Long createUser;

    @Schema(name = "updateUser", title = "操作用户")
    private Long updateUser;

    @Schema(name = "createTime", title = "创建时间")
    private LocalDateTime createTime;

    @Schema(name = "updateTime", title = "记录文件最后修改的时间戳")
    private LocalDateTime updateTime;

    @Schema(name = "isDeleted", title = "文件是否被删除")
    private Boolean isDeleted;

}