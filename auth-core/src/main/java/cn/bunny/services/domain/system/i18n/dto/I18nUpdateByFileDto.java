package cn.bunny.services.domain.system.i18n.dto;

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
@Schema(name = "I18nUpdateByFileDto对象", title = "用文件更新多语言", description = "用文件更新多语言")
public class I18nUpdateByFileDto {

    @Schema(name = "keyName", title = "多语言key")
    @NotBlank(message = "多语言key不能为空")
    private String type;

    @Schema(name = "translation", title = "多语言翻译名称")
    @NotNull(message = "文件不能为空")
    private MultipartFile file;

    @Schema(name = "fileType", title = "文件类型/json/excel")
    @NotBlank(message = "多语言key不能为空")
    private String fileType;

}