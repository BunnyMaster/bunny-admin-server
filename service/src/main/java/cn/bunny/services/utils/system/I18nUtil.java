package cn.bunny.services.utils.system;

import cn.bunny.dao.entity.i18n.I18n;
import org.jetbrains.annotations.NotNull;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class I18nUtil {
    @NotNull
    public static HashMap<String, Object> getMap(List<I18n> i18nList) {
        // 整理集合
        Map<String, Map<String, String>> map = i18nList.stream()
                .collect(Collectors.groupingBy(
                        I18n::getTypeName,
                        Collectors.toMap(I18n::getKeyName, I18n::getTranslation)));

        // 返回集合
        return new HashMap<>(map);
    }
}
