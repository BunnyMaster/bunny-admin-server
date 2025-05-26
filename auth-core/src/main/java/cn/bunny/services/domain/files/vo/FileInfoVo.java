package cn.bunny.services.domain.files.vo;

import cn.bunny.services.domain.common.model.vo.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 返回文件信息
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FileInfoVo对象", title = "管理端返回文件信息", description = "管理端返回文件信息")
public class FileInfoVo extends BaseVo {

    @Schema(name = "filename", title = "文件名称")
    private String filename;

    @Schema(name = "thFilename", title = "缩略图名称")
    private String thFilename;

    @Schema(name = "filepath", title = "存储路径")
    private String filepath;

    @Schema(name = "thUrl", title = "缩略图访问路径")
    private String thUrl;

    @Schema(name = "url", title = "文件访问地址")
    private String url;

    @Schema(name = "size", title = "文件大小，单位字节")
    private Long size;

    @Schema(name = "thSize", title = "缩略图大小，单位字节")
    private Long thSize;

    @Schema(name = "fileSizeStr", title = "文件大小（字符串）")
    private String fileSizeStr;

    @Schema(name = "metadata", title = "文件元数据")
    private String metadata;

    @Schema(name = "thMetadata", title = "缩略图元数据")
    private String thMetadata;

    @Schema(name = "thUserMetadata", title = "缩略图用户元数据")
    private String thUserMetadata;

    @Schema(name = "userMetadata", title = "文件用户元数据")
    private String userMetadata;

    @Schema(name = "objectType", title = "文件所属对象类型，例如用户头像，评价图片")
    private String objectType;

    @Schema(name = "hashInfo", title = "哈希信息")
    private String hashInfo;

    @Schema(name = "attr", title = "附加属性")
    private String attr;

    @Schema(name = "ext", title = "文件扩展名")
    private String ext;

    @Schema(name = "thContentType", title = "缩略图MIME类型")
    private String thContentType;


}
