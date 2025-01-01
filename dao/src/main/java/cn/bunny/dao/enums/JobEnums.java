package cn.bunny.dao.enums;

import lombok.Getter;

@Getter
public enum JobEnums {
    FINISH("finish", "完成"),
    UNFINISHED("unfinished", "未完成"),
    RUNNING("running", "正在运行"),
    ERROR("error", "错误"),
    ;

    private final String type;
    private final String summary;

    JobEnums(String type, String summary) {
        this.type = type;
        this.summary = summary;
    }
}
