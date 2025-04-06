package cn.bunny.service.impl;

import cn.bunny.dao.vo.VmsPathVo;
import cn.bunny.utils.ResourceFileUtil;
import com.alibaba.fastjson2.JSON;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

class VmsServiceImplTest {


    @Test
    void getVmsPathList() throws IOException, URISyntaxException {
        List<String> vmsFiles = ResourceFileUtil.getAbsoluteFiles("vms");
        System.out.println(vmsFiles);

        System.out.println("--------------------------------------------------------------");

        List<String> vmsRelativeFiles = ResourceFileUtil.getRelativeFiles("vms");
        System.out.println(vmsRelativeFiles);

        System.out.println("--------------------------集合对象模式------------------------------------");

        Map<String, List<VmsPathVo>> map = vmsRelativeFiles.stream().map(vmFile -> {
            String[] filepathList = vmFile.split("/");
            String filename = filepathList[filepathList.length - 1].replace(".vm", "");

            return VmsPathVo.builder().name(vmFile).label(filename).type(filepathList[0]).build();
        }).collect(Collectors.groupingBy(VmsPathVo::getType));

        System.out.println(JSON.toJSONString(map));

        System.out.println("----------------------------二维数组格式----------------------------------");
        List<List<VmsPathVo>> listMap = vmsRelativeFiles.stream().map(vmFile -> {
                    String[] filepathList = vmFile.split("/");
                    String filename = filepathList[filepathList.length - 1].replace(".vm", "");

                    return VmsPathVo.builder().name(vmFile).label(filename).type(filepathList[0]).build();
                })
                .collect(Collectors.groupingBy(VmsPathVo::getType))
                .values().stream().toList();

        System.out.println(JSON.toJSONString(listMap));
    }
}