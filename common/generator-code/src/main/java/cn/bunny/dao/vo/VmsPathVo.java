package cn.bunny.dao.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class VmsPathVo {

    /* 路径名称 */
    private String name;

    /* 显示的label */
    private String label;

    /* 文件夹最上级目录名称 */
    private String type;

}
