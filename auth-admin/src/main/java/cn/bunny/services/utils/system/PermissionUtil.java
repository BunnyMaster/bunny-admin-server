package cn.bunny.services.utils.system;

import cn.bunny.services.excel.entity.PermissionExcel;
import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class PermissionUtil {

    /**
     * 构建属性结构
     *
     * @param list 要构建的列表
     * @return 构建完成的列表
     */
    public static List<PermissionExcel> buildTree(List<PermissionExcel> list) {
        List<PermissionExcel> permissionExcels = list.stream()
                .filter(permissionExcel -> permissionExcel.getParentId() == null || permissionExcel.getParentId() == 0)
                .toList();

        for (PermissionExcel permission : permissionExcels) {
            setChildren(permission, list);
        }
        return permissionExcels;
    }

    /**
     * 设置子集
     *
     * @param parent 父级节点
     * @param list   要构建的列表
     */
    private static void setChildren(PermissionExcel parent, List<PermissionExcel> list) {
        List<PermissionExcel> children = list.stream()
                .filter(p -> parent.getId().equals(p.getParentId()))
                .toList();

        if (!children.isEmpty()) {
            parent.setChildren(children);

            for (PermissionExcel child : children) {
                setChildren(child, list);
            }
        }
    }

    /**
     * 写入JSON
     *
     * @param list            写入的列表
     * @param zipOutputStream zip输出流
     * @param zipName         zip文件名
     */
    public static void writeJson(List<PermissionExcel> list, ZipOutputStream zipOutputStream, String zipName) {
        try {
            ZipEntry zipEntry = new ZipEntry(zipName);
            zipOutputStream.putNextEntry(zipEntry);
            zipOutputStream.write(JSON.toJSONString(list).getBytes(StandardCharsets.UTF_8));
            zipOutputStream.closeEntry();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 写入JSON
     *
     * @param list            写入的列表
     * @param zipOutputStream zip输出流
     * @param zipName         zip文件名
     */
    public static void writExcel(List<PermissionExcel> list, ZipOutputStream zipOutputStream, String zipName) {
        try {
            ByteArrayOutputStream excelOutputStream = new ByteArrayOutputStream();

            EasyExcel.write(excelOutputStream, PermissionExcel.class).sheet("permission").doWrite(list);

            // 将Excel写入到Zip中
            ZipEntry zipEntry = new ZipEntry(zipName);
            zipOutputStream.putNextEntry(zipEntry);
            zipOutputStream.write(excelOutputStream.toByteArray());
            zipOutputStream.closeEntry();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 将属性结构扁平化
     *
     * @param list 属性结构
     * @return 扁平化数组
     */
    public static List<PermissionExcel> flattenTree(List<PermissionExcel> list) {
        List<PermissionExcel> result = new ArrayList<>();

        for (PermissionExcel node : list) {
            result.add(node);
            if (node.getChildren() != null && !node.getChildren().isEmpty()) {
                result.addAll(flattenTree(node.getChildren()));
            }
        }

        return result;
    }
}
