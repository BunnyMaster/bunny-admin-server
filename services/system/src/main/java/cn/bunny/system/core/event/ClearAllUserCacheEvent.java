package cn.bunny.system.core.event;

import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

@Getter
@Setter
public class ClearAllUserCacheEvent extends ApplicationEvent {
    private final String key;

    public ClearAllUserCacheEvent(Object source, String key) {
        super(source);
        this.key = key;
    }
}