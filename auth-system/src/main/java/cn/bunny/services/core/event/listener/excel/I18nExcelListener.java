package cn.bunny.services.core.event.listener.excel;

import cn.bunny.domain.common.model.dto.excel.I18nExcel;
import cn.bunny.domain.configuration.entity.I18n;
import cn.bunny.services.service.configuration.I18nService;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.read.listener.ReadListener;
import com.alibaba.excel.util.ListUtils;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

// 有个很重要的点 I18nExcelListener 不能被spring管理，要每次读取excel都要new,然后里面用到spring可以构造方法传进去
@Slf4j
public class I18nExcelListener implements ReadListener<I18nExcel> {

    private static final int BATCH_COUNT = 100;
    private final I18nService i18nService;
    private final String type;
    private List<I18nExcel> cachedDataList = ListUtils.newArrayListWithExpectedSize(BATCH_COUNT);

    public I18nExcelListener(I18nService i18nService, String type) {
        this.i18nService = i18nService;
        this.type = type;
    }

    /**
     * 这个每一条数据解析都会来调用
     *
     * @param data    one row value. Is is same as {@link AnalysisContext#readRowHolder()}
     * @param context AnalysisContext
     */
    @Override
    public void invoke(I18nExcel data, AnalysisContext context) {
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
        List<I18n> i18nList = cachedDataList.stream().map(item -> {
            String key = item.getKeyName();
            String value = item.getTranslation();

            I18n i18n = new I18n();
            i18n.setTypeName(type);
            i18n.setKeyName(key);
            i18n.setTranslation(value);
            return i18n;
        }).toList();

        i18nService.saveBatch(i18nList);
    }
}