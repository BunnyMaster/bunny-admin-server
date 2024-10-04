package cn.bunny.dao.dto.system.files;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FileUploadDto对象", title = "文件上传", description = "文件上传管理")
public class FileUploadDto {

    @Schema(name = "file", title = "文件")
    MultipartFile file;

    @Schema(name = "type", title = "文件类型")
    String type;

}