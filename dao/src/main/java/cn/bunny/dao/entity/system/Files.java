package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 系统文件表
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_files")
@ApiModel(value = "Files对象", description = "系统文件表")
public class Files extends BaseEntity {

    @Schema(name = "filename", title = "文件的名称")
    private String filename;

    @Schema(name = "filepath", title = "文件在服务器上的存储路径")
    private String filepath;

    @Schema(name = "fileSize", title = "文件的大小，以字节为单位")
    private Long fileSize;

    @Schema(name = "fileType", title = "文件的MIME类型")
    private String fileType;

    @Schema(name = "downloadCount", title = "下载数量")
    private Integer downloadCount;

}
