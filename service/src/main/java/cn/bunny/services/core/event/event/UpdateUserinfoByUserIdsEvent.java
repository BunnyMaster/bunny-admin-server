package cn.bunny.services.core.event.event;

import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

import java.util.List;

@Getter
@Setter
public class UpdateUserinfoByUserIdsEvent extends ApplicationEvent {
    private final List<Long> userIds;

    public UpdateUserinfoByUserIdsEvent(Object source, List<Long> userIds) {
        super(source);
        this.userIds = userIds;
    }
}

