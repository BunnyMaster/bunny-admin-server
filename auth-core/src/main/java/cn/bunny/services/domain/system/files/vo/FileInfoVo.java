package cn.bunny.services.domain.system.files.vo;

import cn.bunny.services.domain.common.vo.BaseVo;
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

    @Schema(name = "url", title = "文件的路径")
    private String url;

    @Schema(name = "filename", title = "文件的名称")
    private String filename;

    @Schema(name = "filepath", title = "文件在服务器上的存储路径")
    private String filepath;

    @Schema(name = "fileSize", title = "文件的大小，以字节为单位")
    private Long fileSize;

    @Schema(name = "size", title = "文件大小")
    private String size;

    @Schema(name = "fileType", title = "文件的MIME类型")
    private String fileType;

}
