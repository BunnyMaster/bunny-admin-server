package cn.bunny.services.service.configuration.helper.i18n;

import cn.bunny.services.domain.common.model.dto.excel.I18nExcel;
import cn.bunny.services.domain.system.i18n.entity.I18n;
import cn.bunny.services.service.configuration.impl.I18nServiceImpl;
import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import org.jetbrains.annotations.NotNull;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class I18nHelper {
    /**
     * 将国际化资源列表写入Excel并打包到ZIP输出流
     *
     * <p>处理流程：</p>
     * <ol>
     *   <li>按资源类型(typeName)分组 --- 多语言的类型，英文?中文?</li>
     *   <li>每组数据生成单独多语言 key的Excel工作表</li>
     *   <li>将Excel文件写入ZIP输出流</li>
     * </ol>
     *
     * @param i18nList        国际化资源列表，包含key-value对和类型信息
     * @param zipOutputStream ZIP输出流，用于写入打包后的Excel文件
     * @throws RuntimeException 当IO操作失败时抛出
     */
    public static void writeExcel(List<I18n> i18nList, ZipOutputStream zipOutputStream) {
        Map<String, List<I18nExcel>> hashMap = i18nList.stream()
                .collect(Collectors.groupingBy(
                        I18n::getTypeName,
                        Collectors.mapping((I18n i18n) -> {
                            String keyName = i18n.getKeyName();
                            String translation = i18n.getTranslation();
                            return I18nExcel.builder().keyName(keyName).translation(translation).build();
                        }, Collectors.toList())
                ));


        hashMap.forEach((key, value) -> {
            try {
                // 创建临时ByteArrayOutputStream
                ByteArrayOutputStream excelOutputStream = new ByteArrayOutputStream();

                ZipEntry zipEntry = new ZipEntry(key + ".xlsx");
                zipOutputStream.putNextEntry(zipEntry);

                // 先写入到临时流
                EasyExcel.write(excelOutputStream, I18nExcel.class).sheet(key).doWrite(value);
                zipOutputStream.write(excelOutputStream.toByteArray());
                zipOutputStream.closeEntry();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
    }

    /**
     * 将国际化资源列表写入JSON并打包到ZIP输出流
     *
     * <p>处理流程：</p>
     * <ol>
     *   <li>按资源类型(typeName)分组 --- 多语言的类型，英文?中文?</li>
     *   <li>每组数据生成单独多语言 key的Excel工作表</li>
     *   <li>将JSON文件写入ZIP输出流</li>
     * </ol>
     *
     * @param i18nList        国际化资源列表
     * @param zipOutputStream ZIP输出流
     * @throws RuntimeException 当IO操作失败时抛出
     */
    public static void writeJson(List<I18n> i18nList, ZipOutputStream zipOutputStream) {
        HashMap<String, Object> hashMap = getMapByI18nList(i18nList);

        hashMap.forEach((k, v) -> {
            try {
                ZipEntry zipEntry = new ZipEntry(k + ".json");
                zipOutputStream.putNextEntry(zipEntry);

                zipOutputStream.write(JSON.toJSONString(v).getBytes(StandardCharsets.UTF_8));
                zipOutputStream.closeEntry();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });
    }

    /**
     * 将国际化资源列表转换为结构化Map
     *
     * <p>转换规则：</p>
     * <ul>
     *   <li>外层Key: 资源类型(typeName)</li>
     *   <li>内层Key: 资源键名(keyName)</li>
     *   <li>值: 翻译文本(translation)</li>
     * </ul>
     * <p>详细结构和结果示例看前端传递的 {@link I18nServiceImpl#getI18nMap} 控制器</p>
     * <p>/api/i18n/public</p>
     *
     * @param i18nList 国际化资源列表
     * @return 结构化Map {typeName: {keyName: translation}}
     * @throws IllegalArgumentException 当参数为null时抛出
     */
    @NotNull
    public static HashMap<String, Object> getMapByI18nList(@NotNull List<I18n> i18nList) {
        // 整理集合
        Map<String, Map<String, String>> map = i18nList.stream()
                .collect(Collectors.groupingBy(
                        I18n::getTypeName,
                        Collectors.toMap(I18n::getKeyName, I18n::getTranslation)));

        // 返回集合
        return new HashMap<>(map);
    }
}
