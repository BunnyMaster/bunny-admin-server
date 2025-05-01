package cn.bunny.services.domain.common.model.dto.minio;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "MinioFilePath", title = "Minion上传返回西悉尼")
public class MinioUploadFileInfo {

    @Schema(name = "filename", title = "文件名")
    private String filename;

    @Schema(name = "uuidFilename", title = "uuid文件名，防止重复")
    private String uuidFilename;

    @Schema(name = "timeUuidFilename", title = "时间+uuid文件名")
    private String timeUuidFilename;

    @Schema(name = "filepath", title = "文件路径")
    private String filepath;

    @Schema(name = "bucketNameFilepath", title = "上传桶名称文件路径")
    private String bucketNameFilepath;

}
