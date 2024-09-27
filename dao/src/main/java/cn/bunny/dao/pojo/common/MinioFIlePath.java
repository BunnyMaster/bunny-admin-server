package cn.bunny.dao.pojo.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MinioFIlePath {
    private String filename;
    private String uuidFilename;
    private String timeUuidFilename;
    private String filepath;
    private String bucketNameFilepath;
}
