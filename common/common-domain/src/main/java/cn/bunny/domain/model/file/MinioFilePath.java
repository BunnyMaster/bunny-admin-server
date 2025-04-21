package cn.bunny.domain.model.file;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MinioFilePath {
    private String filename;
    private String uuidFilename;
    private String timeUuidFilename;
    private String filepath;
    private String bucketNameFilepath;
}
