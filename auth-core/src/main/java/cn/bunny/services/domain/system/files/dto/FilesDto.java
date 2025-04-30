package cn.bunny.services.domain.system.files.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FilesDto对象", title = "文件分页查询", description = "文件分页查询")
public class FilesDto {

    @Schema(name = "filename", title = "文件的名称")
    private String filename;

    @Schema(name = "filepath", title = "文件在服务器上的存储路径")
    private String filepath;

    @Schema(name = "fileType", title = "文件的MIME类型")
    private String fileType;

    @Schema(name = "downloadCount", title = "下载数量")
    private Integer downloadCount;

}