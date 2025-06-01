package cn.bunny.core.utils;

import cn.bunny.domain.common.model.dto.ip.IpEntity;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.lionsoul.ip2region.xdb.Searcher;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.io.InputStream;
import java.net.InetAddress;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 用户请求的IP地址转成归属地
 */
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
            log.error("ip转换错误消息：{}", exception.getMessage());
            log.error("ip转换错误栈：{}", (Object) exception.getStackTrace());
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
                        // 国内属地返回省份和地区
                        return splitIpInfo[2] + "," + splitIpInfo[3] + " " + splitIpInfo[4];
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
                log.error("获取 ip 所属地址消息：{}", exception.getMessage());
                log.error("获取 ip 所属地址：{}", (Object) exception.getStackTrace());
            }
            return "";
        } else {
            throw new IllegalArgumentException("非法的IP地址");
        }
    }

    /**
     * * 获取当前用户登录IP地址
     *
     * @return IP地址
     */
    public static IpEntity getCurrentUserIpAddress() {
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        // 判断IP地址归属地
        String remoteAddr = requestAttributes != null ? getIpAddr(requestAttributes.getRequest()) : "0:0:0:0:0:0:0:1";
        String ipRegion = IpUtil.getIpRegion(remoteAddr);

        // 转成环回地址
        remoteAddr = remoteAddr.equals("0:0:0:0:0:0:0:1") ? "127.0.0.1" : remoteAddr;
        return IpEntity.builder().ipAddr(remoteAddr).ipRegion(ipRegion).build();
    }

    /**
     * * 获取IP地址
     *
     * @param request 请求头
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ipAddress;
        try {
            ipAddress = request.getHeader("x-forwarded-for");
            if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("WL-Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getRemoteAddr();
                if (ipAddress.equals("127.0.0.1")) ipAddress = InetAddress.getLocalHost().getHostAddress();
            }
            // 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
            if (ipAddress != null && ipAddress.length() > 15) {
                if (ipAddress.indexOf(",") > 0) {
                    ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
                }
            }
        } catch (Exception e) {
            ipAddress = null;
        }
        return ipAddress;
    }

    /**
     * 替换IP地址格式：127.**.**.1 、192.**.**.100
     *
     * @param ipAddress IP地址
     * @return 新的IP地址格式
     */
    public static String replaceIp(String ipAddress) {
        return ipAddress.replaceAll("(\\d{1,3}\\.)(\\d{1,3}\\.)(\\d{1,3}\\.)(\\d{1,3})", "$1**.**.$4");
    }
}
