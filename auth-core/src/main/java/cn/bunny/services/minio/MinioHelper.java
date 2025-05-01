package cn.bunny.services.minio;

import cn.bunny.services.domain.common.constant.UserConstant;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

@Component
public class MinioHelper {
    
    @Resource
    private MinioProperties properties;

    /**
     * 格式化用户头像URL
     *
     * <p>实现头像URL的统一存储和访问格式转换：</p>
     *
     * <ol>
     *   <li><b>存储处理</b>：将带HTTP前缀的头像URL转换为数据库存储格式
     *     <ul>
     *       <li>匹配正则表达式：^https?://.*?/(.*)</li>
     *       <li>提取路径部分：matcher.group(1)</li>
     *       <li>转换为存储格式："/" + 提取的路径</li>
     *     </ul>
     *   </li>
     *   <li><b>访问处理</b>：返回带HTTP前缀的完整访问URL</li>
     * </ol>
     *
     * <p>典型用例：</p>
     * <pre>
     * 输入："http|s://example.com/images/avatar.jpg"
     * 存储："images/avatar.jpg"
     * 访问："http|s://xxx/images/avatar.jpg"
     * </pre>
     *
     * @param avatar 头像URL（可能包含HTTP前缀或数据库存储格式）
     * @return 格式化后的头像URL（确保包含HTTP前缀）
     * @throws PatternSyntaxException   当正则表达式匹配失败时抛出
     * @throws IllegalArgumentException 当头像参数为空时抛出
     */
    public String formatUserAvatar(String avatar) {
        // 如果用户没有头像或者用户头像和默认头像相同，返回默认头像
        String userAvatar = UserConstant.USER_AVATAR;
        if (!StringUtils.hasText(avatar) || avatar.equals(userAvatar)) return userAvatar;

        // 替换前端发送的host前缀，将其删除，只保留路径名称
        String regex = "^https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(avatar);

        // 如果没有匹配
        if (!matcher.matches()) return avatar;

        // 匹配后返回内容
        return "/" + matcher.group(1);
    }

    /**
     * 检查并格式化用户头像URL
     *
     * <p>处理逻辑：</p>
     * <ol>
     *   <li>当头像为空或与默认头像相同时，返回系统默认头像</li>
     *   <li>尝试移除头像URL中的HTTP协议和域名部分（如果存在）</li>
     *   <li>最终返回MinIO存储中的完整对象访问路径</li>
     * </ol>
     *
     * @param avatar 用户头像URL，可能为以下格式：
     *               - 空/null（使用默认头像）
     *               - 完整HTTP URL（如"http|s://example.com/images/1.jpg"）
     *               - MinIO对象路径（如"images/1.jpg"）
     * @return 格式化后的头像URL，保证是可访问的完整路径
     * - 默认头像（当输入无效时）
     * - MinIO完整访问路径（处理成功时）
     * @see UserConstant#USER_AVATAR 默认头像常量
     * @see #getObjectNameFullPath MinIO路径处理方法
     */
    public String getUserAvatar(String avatar) {
        // 如果用户没有头像或者用户头像和默认头像相同，返回默认头像
        String userAvatar = UserConstant.USER_AVATAR;
        if (!StringUtils.hasText(avatar) || avatar.equals(userAvatar)) return userAvatar;

        // 替换前端发送的host前缀，将其删除，只保留路径名称
        String regex = "^https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(avatar);

        // 如果没有匹配
        if (matcher.matches()) return avatar;

        // 匹配后返回内容
        return getObjectNameFullPath(avatar);
    }

    /**
     * 获取Minio全路径名，Object带有桶名称
     *
     * @param objectName 对象名称
     * @return 全路径
     */
    public String getObjectNameFullPath(String objectName) {
        String url = properties.getEndpointUrl();

        return url + objectName;
    }
}
