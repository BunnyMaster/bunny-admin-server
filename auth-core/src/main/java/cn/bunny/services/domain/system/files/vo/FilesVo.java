package cn.bunny.services.domain.system.files.vo;

import cn.bunny.services.domain.common.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FilesVo对象", title = "系统文件", description = "管理端系统文件返回信息")
public class FilesVo extends BaseUserVo {

    @Schema(name = "filename", title = "文件的名称")
    private String filename;

    @Schema(name = "filepath", title = "文件在服务器上的存储路径")
    private String filepath;

    @Schema(name = "fileSize", title = "文件的大小，以字节为单位")
    private Long fileSize;

    @Schema(name = "fileType", title = "文件的MIME类型")
    private String fileType;

    @Schema(name = "downloadCount", title = "下载数量")
    private Integer downloadCount;

}