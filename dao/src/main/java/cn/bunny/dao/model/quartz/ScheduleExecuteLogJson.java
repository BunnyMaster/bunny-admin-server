package cn.bunny.dao.model.quartz;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "QuartzExecuteLog对象", title = "执行任务的日志", description = "执行任务的日志")
public class ScheduleExecuteLogJson {

    @Schema(name = "result", title = "执行结果")
    private String result;

    @Schema(name = "status", title = "执行状态")
    private String status;

    @Schema(name = "message", title = "执行消息")
    private String message;

    @Schema(name = "operationTime", title = "操作时间")
    private String operationTime;

    @Schema(name = "executeParams", title = "执行任务参数")
    private Map<String, Object> executeParams;
}
