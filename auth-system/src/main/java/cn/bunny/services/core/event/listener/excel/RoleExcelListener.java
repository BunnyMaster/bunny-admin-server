package cn.bunny.services.core.event.listener.excel;

import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.dto.excel.RoleExcel;
import cn.bunny.domain.system.entity.Role;
import cn.bunny.core.exception.AuthCustomerException;
import cn.bunny.services.service.system.RoleService;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.read.listener.ReadListener;
import com.alibaba.excel.util.ListUtils;
import com.alibaba.excel.util.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;

import java.util.List;

@Slf4j
public class RoleExcelListener implements ReadListener<RoleExcel> {

    private static final int BATCH_COUNT = 100;
    private final RoleService roleService;
    private List<RoleExcel> cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);

    public RoleExcelListener(RoleService roleService) {
        this.roleService = roleService;
    }

    @Override
    public void invoke(RoleExcel roleExcel, AnalysisContext analysisContext) {
        cachedDataList.add(roleExcel);
        // 达到BATCH_COUNT了，需要去存储一次数据库，防止数据几万条数据在内存，容易OOM
        if (cachedDataList.size() >= BATCH_COUNT) {
            saveData();
            // 存储完成清理 list
            cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);
        }
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        saveData();
    }

    private void saveData() {
        List<Role> roleList = cachedDataList.stream().map(item -> {
            Role role = new Role();
            BeanUtils.copyProperties(item, role);

            // id 不为空设置
            String id = item.getId();
            if (!StringUtils.isEmpty(id)) {
                role.setId(Long.valueOf(id));
            }
            return role;
        }).toList();

        if (roleList.isEmpty()) {
            throw new AuthCustomerException(ResultCodeEnum.DATA_TOO_LARGE);
        }
        roleService.saveOrUpdateBatch(roleList, BATCH_COUNT);
    }
} 