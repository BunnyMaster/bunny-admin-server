package cn.bunny.services.processor;

import java.util.List;

/* 构建树型结构模板处理器 */
public abstract class TreeProcessor<T> {
    public final List<T> process(List<T> list) {
        List<T> roots = findRoots(list);
        for (T root : roots) {
            buildChildren(root, list);
        }
        return roots;
    }

    protected abstract List<T> findRoots(List<T> list);

    protected abstract void buildChildren(T parent, List<T> list);
}
