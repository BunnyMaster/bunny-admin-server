package cn.bunny.common.service.utils;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.lionsoul.ip2region.xdb.Searcher;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.FileCopyUtils;

import java.io.InputStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
public class IpUtil {
    private static Searcher searcher;

    /**
     * 判断是否为合法 IP
     */
    public static boolean checkIp(String ipAddress) {
        String ip = "([1-9]|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}";
        Pattern pattern = Pattern.compile(ip);
        Matcher matcher = pattern.matcher(ipAddress);
        return matcher.matches();
    }

    /**
     * 在服务启动时，将 ip2region 加载到内存中
     */
    @PostConstruct
    private static void initIp2Region() {
        try {
            InputStream inputStream = new ClassPathResource("/ipdb/ip2region.xdb").getInputStream();
            byte[] bytes = FileCopyUtils.copyToByteArray(inputStream);
            searcher = Searcher.newWithBuffer(bytes);
        } catch (Exception exception) {
            log.error(exception.getMessage());
        }
    }

    /**
     * 获取 ip 所属地址
     *
     * @param ip ip
     */
    public static String getIpRegion(String ip) {
        if (ip.equals("0:0:0:0:0:0:0:1")) ip = "127.0.0.1";
        boolean isIp = checkIp(ip);
        if (isIp) {
            initIp2Region();
            try {
                // searchIpInfo 的数据格式： 国家|区域|省份|城市|ISP
                String searchIpInfo = searcher.search(ip);
                String[] splitIpInfo = searchIpInfo.split("\\|");
                if (splitIpInfo.length > 0) {
                    if ("中国".equals(splitIpInfo[0])) {
                        // 国内属地返回省份
                        return splitIpInfo[2];
                    } else if ("0".equals(splitIpInfo[0])) {
                        if ("内网IP".equals(splitIpInfo[4])) {
                            // 内网 IP
                            return splitIpInfo[4];
                        } else {
                            return "";
                        }
                    } else {
                        // 国外属地返回国家
                        return splitIpInfo[0];
                    }
                }
            } catch (Exception exception) {
                log.error(exception.getMessage());
            }
            return "";
        } else {
            throw new IllegalArgumentException("非法的IP地址");
        }
    }
}
