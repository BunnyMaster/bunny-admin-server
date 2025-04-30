package cn.bunny.services.domain.common.constant;

import java.util.ArrayList;
import java.util.List;

public class SecurityConfigConstant {
    public static String[] REQUEST_MATCHERS_PERMIT_ALL = {
            "/", "/**.html", "/error", "/media.ico", "/favicon.ico",
            "/webjars/**", "/v3/api-docs/**", "/swagger-ui/**",
            "/*/*/noAuth/**", "/*/noAuth/**", "/noAuth/**",
            "/*/i18n/getI18n"
    };

    public static List<String> PERMIT_ALL_LIST = new ArrayList<>() {{
        add("admin");
    }};
}
