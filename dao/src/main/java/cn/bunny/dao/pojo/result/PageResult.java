package cn.bunny.dao.pojo.result;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * 封装分页查询结果
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PageResult<T> implements Serializable {
    // 当前页
    private Integer pageNo;
    // 每页记录数
    private Integer pageSize;
    // 总记录数
    private long total;
    // 当前页数据集合
    private List<T> list;
}