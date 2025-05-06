package cn.bunny.services.core.strategy.export;

import java.io.IOException;
import java.util.zip.ZipOutputStream;

public interface ExportStrategy<T> {
    void export(T data, ZipOutputStream zipOutputStream, String filename) throws IOException;
}