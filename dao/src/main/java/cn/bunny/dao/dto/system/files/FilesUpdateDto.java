package cn.bunny.dao.dto.system.files;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FilesUpdateDto对象", title = "文件", description = "文件管理")
public class FilesUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "filename", title = "文件的名称")
    @NotBlank(message = "文件的名称不能为空")
    @NotNull(message = "文件的名称不能为空")
    private String filename;

    @Schema(name = "filepath", title = "文件在服务器上的存储路径")
    @NotBlank(message = "存储路径不能为空")
    @NotNull(message = "存储路径不能为空")
    private String filepath;

    @Schema(name = "fileType", title = "文件的MIME类型")
    @NotBlank(message = "文件类型不能为空")
    @NotNull(message = "文件类型不能为空")
    private String fileType;

    @Schema(name = "downloadCount", title = "下载数量")
    private Integer downloadCount;

}