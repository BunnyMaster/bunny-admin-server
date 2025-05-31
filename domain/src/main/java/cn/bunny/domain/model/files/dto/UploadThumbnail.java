package cn.bunny.domain.model.files.dto;

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
@Schema(name = "UploadThumbnail对象", title = "上传图片文件")
public class UploadThumbnail {

    @Schema(name = "file", title = "图片")
    MultipartFile file;

    @Schema(name = "preType", title = "类型（路径）")
    String preType;

    @Schema(name = "thumbnailSuffix", title = "缩略图后缀")
    String thumbnailSuffix;

    @Schema(name = "saveThFilename", title = "保存文件名称，不包含扩展名")
    String saveThFilename;

}
