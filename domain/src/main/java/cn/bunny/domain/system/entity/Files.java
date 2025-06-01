package cn.bunny.domain.system.entity;

import cn.bunny.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
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
@TableName("sys_files" )
@Schema(name = "Files对象" , title = "文件记录" )
public class Files extends BaseEntity {

    @Schema(name = "thSize" , title = "缩略图大小，单位字节" )
    private Long thSize;

    @Schema(name = "size" , title = "文件大小，单位字节" )
    private Long size;

    @Schema(name = "fileSizeStr" , title = "文件大小（字符串）" )
    private String fileSizeStr;

    @Schema(name = "uploadStatus" , title = "上传状态，仅在手动分片上传时使用，1：初始化完成，2：上传完成" )
    private Integer uploadStatus;

    @Schema(name = "filename" , title = "文件名称" )
    private String filename;

    @Schema(name = "objectType" , title = "文件所属对象类型，例如用户头像，评价图片" )
    private String objectType;

    @Schema(name = "hashInfo" , title = "哈希信息" )
    private String hashInfo;

    @Schema(name = "platform" , title = "存储平台" )
    private String platform;

    @Schema(name = "thMetadata" , title = "缩略图元数据" )
    private String thMetadata;

    @Schema(name = "thUrl" , title = "缩略图访问路径" )
    private String thUrl;

    @Schema(name = "thUserMetadata" , title = "缩略图用户元数据" )
    private String thUserMetadata;

    @Schema(name = "uploadId" , title = "上传ID，仅在手动分片上传时使用" )
    private String uploadId;

    @Schema(name = "fileAcl" , title = "文件ACL" )
    private String fileAcl;

    @Schema(name = "url" , title = "文件访问地址" )
    private String url;

    @Schema(name = "thFilename" , title = "缩略图名称" )
    private String thFilename;

    @Schema(name = "userMetadata" , title = "文件用户元数据" )
    private String userMetadata;

    @Schema(name = "filepath" , title = "存储路径" )
    private String filepath;

    @Schema(name = "attr" , title = "附加属性" )
    private String attr;

    @Schema(name = "ext" , title = "文件扩展名" )
    private String ext;

    @Schema(name = "thContentType" , title = "缩略图MIME类型" )
    private String thContentType;

    @Schema(name = "metadata" , title = "文件元数据" )
    private String metadata;

    @Schema(name = "objectId" , title = "文件所属对象id" )
    private String objectId;

    @Schema(name = "downloadCount" , title = "下载数量" )
    private Integer downloadCount;

    @Schema(name = "thFileAcl" , title = "缩略图文件ACL" )
    private String thFileAcl;

    @Schema(name = "originalFilename" , title = "原始文件名" )
    private String originalFilename;

    @Schema(name = "contentType" , title = "MIME类型" )
    private String contentType;

    @Schema(name = "basePath" , title = "基础存储路径" )
    private String basePath;

    @Schema(name = "isDeleted" , title = "文件是否被删除" )
    @TableField(exist = false)
    private Boolean isDeleted;

}