package cn.bunny.services.service.system.helper;

import cn.bunny.services.domain.common.model.dto.excel.PermissionExcel;
import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 权限数据处理工具类
 *
 * <p>提供权限数据的树形结构处理、扁平化处理以及导出功能</p>
 */
public class PermissionHelper {

    /**
     * 将树形结构权限数据扁平化为列表
     *
     * <p>使用递归处理树形结构</p>
     *
     * @param list 树形结构的权限列表，每个节点可能包含children子节点
     * @return 扁平化后的权限列表（
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

    /**
     * 递归设置子节点（内部方法）
     *
     * <p>为父节点查找并设置所有子节点，递归处理子节点的子节点</p>
     *
     * @param parent 当前父节点
     * @param list   完整的权限数据列表
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
     * 构建权限树形结构
     *
     * <p>从扁平列表中构建树形结构，根节点的判断条件为parentId为null或0</p>
     *
     * @param list 扁平化的权限数据列表
     * @return 构建完成的树形结构列表（只包含根节点）
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
     * 将权限数据写入JSON格式到ZIP压缩包
     *
     * @param list            要导出的权限数据列表
     * @param zipOutputStream ZIP输出流
     * @param zipName         在ZIP包中的文件名
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
     * 将权限数据写入Excel格式到ZIP压缩包
     *
     * @param list            要导出的权限数据列表
     * @param zipOutputStream ZIP输出流
     * @param zipName         在ZIP包中的文件名（需包含.xlsx后缀）
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
}
