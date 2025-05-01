package cn.bunny.services.domain.common.constant;

import java.util.ArrayList;
import java.util.List;

public class SecurityConfigConstant {

    /* 可以放行的权限 */
    public static List<String> PERMIT_ACCESS_LIST = new ArrayList<>() {{
        add("admin");
    }};
}
