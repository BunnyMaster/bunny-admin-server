package cn.bunny.domain.system.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "FilesDto对象" , title = "文件分页查询" , description = "文件分页查询" )
public class FilesDto {

    @Schema(name = "filename" , title = "文件的名称" )
    private String filename;

    @Schema(name = "filepath" , title = "文件在服务器上的存储路径" )
    private String filepath;

    @Schema(name = "contentType" , title = "文件的MIME类型" )
    private String contentType;

    @Schema(name = "ext" , title = "扩展名" )
    private String ext;

    @Schema(name = "platform" , title = "存储平台" )
    private String platform;

    @Schema(name = "downloadCount" , title = "下载数量" )
    private Integer downloadCount;

}