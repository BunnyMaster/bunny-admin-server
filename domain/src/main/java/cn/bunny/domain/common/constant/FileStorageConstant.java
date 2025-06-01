package cn.bunny.domain.common.constant;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class FileStorageConstant {
    public static final String FAVICON = "favicon";
    public static final String AVATAR = "avatar";
    public static final String MESSAGE = "message";
    public static final String CAROUSEL = "carousel";
    public static final String BACKUP = "backup";
    public static final String IMAGES = "images";
    public static final String VIDEO = "video";
    public static final Map<String, String> typeMap = new HashMap<>();

    static {
        typeMap.put(FAVICON, "/" + FAVICON + "/");
        typeMap.put(AVATAR, "/" + AVATAR + "/");
        typeMap.put(MESSAGE, "/" + MESSAGE + "/");
        typeMap.put(CAROUSEL, "/" + CAROUSEL + "/");
        typeMap.put(BACKUP, "/" + BACKUP + "/");
        typeMap.put(IMAGES, "/" + IMAGES + "/");
        typeMap.put(VIDEO, "/" + VIDEO + "/");
        typeMap.put("default", "/" + "default" + "/");
    }

    public static String getType(String type) {
        String value = typeMap.get(type);
        if (value != null) return value;
        throw new RuntimeException("上传类型错误或缺失");
    }
}
