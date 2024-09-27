package cn.bunny.common.service.utils;

import org.springframework.stereotype.Component;

@Component
public class FileUtil {
    /**
     * * 获取文件大小字符串
     */
    public static String getSize(Long fileSize) {
        double fileSizeInKB = fileSize / 1024.00;
        double fileSizeInMB = fileSizeInKB / 1024;
        double fileSizeInGB = fileSizeInMB / 1024;

        String size;
        if (fileSizeInGB >= 1) {
            fileSizeInGB = Double.parseDouble(String.format("%.2f", fileSizeInGB));
            size = fileSizeInGB + "GB";
        } else if (fileSizeInMB >= 1) {
            fileSizeInMB = Double.parseDouble(String.format("%.2f", fileSizeInMB));
            size = fileSizeInMB + "MB";
        } else if (fileSizeInKB >= 1) {
            fileSizeInKB = Double.parseDouble(String.format("%.2f", fileSizeInKB));
            size = fileSizeInKB + "KB";
        } else {
            size = fileSize + "B";
        }

        return size;
    }
}
