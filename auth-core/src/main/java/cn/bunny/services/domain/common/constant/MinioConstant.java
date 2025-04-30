package cn.bunny.services.domain.common.constant;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class MinioConstant {
    public static final String favicon = "favicon";
    public static final String avatar = "avatar";
    public static final String message = "message";
    public static final String carousel = "carousel";
    public static final String feedback = "feedback";
    public static final String backup = "backup";
    public static final Map<String, String> typeMap = new HashMap<>();

    static {
        typeMap.put(favicon, "/favicon/");
        typeMap.put(avatar, "/avatar/");
        typeMap.put(message, "/message/");
        typeMap.put(carousel, "/carousel/");
        typeMap.put(feedback, "/feedback/");
        typeMap.put(backup, "/backup/");
        typeMap.put("images", "/images/");
        typeMap.put("video", "/video/");
        typeMap.put("default", "/default/");
    }

    public static String getType(String type) {
        String value = typeMap.get(type);
        if (value != null) return value;
        throw new RuntimeException("上传类型错误或缺失");
    }
}
