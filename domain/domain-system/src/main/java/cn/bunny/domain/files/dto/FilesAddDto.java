package cn.bunny.domain.files.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FilesAddDto对象", title = "添加文件", description = "添加文件")
public class FilesAddDto {

    @Schema(name = "filepath", title = "文件在服务器上的存储路径")
    @NotBlank(message = "存储路径不能为空")
    private String filepath;

    @Schema(name = "downloadCount", title = "下载数量")
    @Min(value = 0L, message = "最小值为0")
    private Integer downloadCount = 0;

    @Schema(name = "files", title = "文件")
    @NotEmpty(message = "文件不能为空")
    private List<MultipartFile> files;

}