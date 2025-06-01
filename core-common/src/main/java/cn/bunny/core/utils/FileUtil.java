package cn.bunny.core.utils;

import cn.hutool.crypto.digest.MD5;
import org.springframework.http.HttpHeaders;

/*
 * 文件工具类
 * 格式化字节大小
 */
public class FileUtil {
    /**
     * 获取文件大小字符串
     *
     * @param fileSize 文件大小
     * @return 格式化后文件大小
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

    /**
     * 构建二进制文件响应头
     *
     * @param filename 文件名
     * @return HttpHeaders
     */
    public static HttpHeaders buildHttpHeadersByBinary(String filename) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=" + filename);
        headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");

        return headers;
    }

    /* 文件名在前面 */
    public static String buildFilenameBefore(String filename) {
        long currentTimeMillis = System.currentTimeMillis();
        String digestHex = MD5.create().digestHex(currentTimeMillis + "");
        return filename + digestHex;
    }

    /* 文件名在后面 */
    public static String buildFilenameAfter(String filename) {
        long currentTimeMillis = System.currentTimeMillis();
        String digestHex = MD5.create().digestHex(currentTimeMillis + "");
        return digestHex + filename;
    }
}
