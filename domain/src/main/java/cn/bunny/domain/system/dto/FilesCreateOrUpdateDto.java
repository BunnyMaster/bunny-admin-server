package cn.bunny.domain.system.dto;

import cn.bunny.domain.common.ValidationGroups;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "FilesSaveOrUpdateDto对象" , title = "添加/更新文件" , description = "添加/更新文件" )
public class FilesCreateOrUpdateDto {

    @Schema(name = "id" , title = "主键" )
    @NotNull(message = "更新id不为空" , groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "filepath" , title = "文件在服务器上的存储路径" )
    @NotBlank(message = "存储路径不能为空" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String filepath;

    @Schema(name = "downloadCount" , title = "下载数量" )
    @Min(value = 0L, message = "最小值为0" , groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private Integer downloadCount = 0;

    @Schema(name = "files" , title = "文件列表，添加时为列表" )
    @NotEmpty(message = "文件不能为空" , groups = {ValidationGroups.Add.class})
    private List<MultipartFile> files;

    @Schema(name = "file" , title = "文件，修改时为 file" )
    private MultipartFile file;

}