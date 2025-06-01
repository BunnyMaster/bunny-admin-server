package cn.bunny.domain.system.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FileUploadDto对象" , title = "文件上传" , description = "文件上传管理" )
public class FileUploadDto {

    @Schema(name = "file" , title = "文件" )
    @NotNull(message = "文件不能为空" )
    private MultipartFile file;

    @Schema(name = "type" , title = "文件类型" )
    @NotBlank(message = "文件类型不能为空" )
    private String type;

    @Schema(name = "platform" , title = "指定的平台" )
    private String platform;

}