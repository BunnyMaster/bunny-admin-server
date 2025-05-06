package cn.bunny.services.core.excel;

import cn.bunny.services.domain.common.model.dto.excel.PermissionExcel;
import cn.bunny.services.domain.system.system.entity.Permission;
import cn.bunny.services.service.system.PermissionService;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.read.listener.ReadListener;
import com.alibaba.excel.util.ListUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;

import java.util.List;

@Slf4j
public class PermissionExcelListener implements ReadListener<PermissionExcel> {
    private static final int BATCH_COUNT = 100;
    private final PermissionService permissionService;
    private List<PermissionExcel> cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);

    public PermissionExcelListener(PermissionService permissionService) {
        this.permissionService = permissionService;
    }

    /**
     * 这个每一条数据解析都会来调用
     *
     * @param data    one row value. Is is same as {@link AnalysisContext#readRowHolder()}
     * @param context AnalysisContext
     */
    @Override
    public void invoke(PermissionExcel data, AnalysisContext context) {
        cachedDataList.add(data);
        // 达到BATCH_COUNT了，需要去存储一次数据库，防止数据几万条数据在内存，容易OOM
        if (cachedDataList.size() >= BATCH_COUNT) {
            saveData();
            // 存储完成清理 list
            cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);
        }
    }

    /**
     * 所有数据解析完成了 都会来调用
     *
     * @param context AnalysisContext
     */
    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        saveData();
    }

    /**
     * 加上存储数据库
     */
    private void saveData() {
        List<Permission> permissionExcels = cachedDataList.stream().map(item -> {
            Permission permission = new Permission();
            BeanUtils.copyProperties(item, permission);
            return permission;
        }).toList();

        permissionService.saveOrUpdateBatch(permissionExcels);
    }
}
