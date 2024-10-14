package cn.bunny.dao.pojo.constant;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class MinioConstant {
    public static final String favicon = "favicon";
    public static final String avatar = "avatar";
    public static final String article = "article";
    public static final String carousel = "carousel";
    public static final String feedback = "feedback";
    public static final String articleCovers = "articleCovers";
    public static final String articleAttachment = "articleAttachment";
    public static final Map<String, String> typeMap = new HashMap<>();

    static {
        typeMap.put(favicon, "/favicon/");
        typeMap.put(avatar, "/avatar/");
        typeMap.put(article, "/article/");
        typeMap.put(carousel, "/carousel/");
        typeMap.put(feedback, "/feedback/");
        typeMap.put("articleImages", "/articleImages/");
        typeMap.put("articleVideo", "/articleVideo/");
        typeMap.put(articleCovers, "/articleCovers/");
        typeMap.put(articleAttachment, "/articleAttachment/");
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
