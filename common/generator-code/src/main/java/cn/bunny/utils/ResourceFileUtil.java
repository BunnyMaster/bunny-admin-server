package cn.bunny.utils;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.List;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.stream.Stream;

public class ResourceFileUtil {

    /**
     * 获取目标文件夹下所有文件完整路径
     *
     * @param dirname 文件夹名称
     * @return 目标文件完整路径
     * @throws IOException IOException
     */
    public static List<String> getAbsoluteFiles(String dirname) throws IOException {
        List<String> fileNames = new ArrayList<>();

        // 加载当前类
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        Enumeration<URL> urls = classLoader.getResources(dirname);

        while (urls.hasMoreElements()) {
            URL url = urls.nextElement();
            if (url.getProtocol().equals("file")) {
                // 文件系统
                File file = new File(url.getFile());
                if (file.isDirectory()) {
                    addFullFilesFromDirectory(file, fileNames);
                }
            } else if (url.getProtocol().equals("jar")) {
                // JAR文件
                String jarPath = url.getPath().substring(5, url.getPath().indexOf("!"));
                try (JarFile jar = new JarFile(jarPath)) {
                    Enumeration<JarEntry> entries = jar.entries();
                    while (entries.hasMoreElements()) {
                        String name = entries.nextElement().getName();
                        if (name.startsWith(dirname + "/") && !name.endsWith("/")) {
                            fileNames.add(name);
                        }
                    }
                }
            }
        }

        return fileNames;
    }

    /**
     * 添加文件
     * 获取目标文件夹下所有文件完整路径
     *
     * @param directory 文件夹
     * @param fileNames 文件名称
     */
    private static void addFullFilesFromDirectory(File directory, List<String> fileNames) {
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isFile()) {
                    fileNames.add(file.getPath());
                } else if (file.isDirectory()) {
                    addFullFilesFromDirectory(file, fileNames);
                }
            }
        }
    }

    /**
     * 获取相对文件夹路径
     *
     * @return 相对当前的文件夹路径
     * @throws IOException        IOException
     * @throws URISyntaxException URISyntaxException
     */
    public static List<String> getRelativeFiles(String dirname) throws IOException, URISyntaxException {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        URL resource = classLoader.getResource(dirname);

        if (resource == null) return Collections.emptyList();

        // 处理JAR包内的情况
        if (resource.getProtocol().equals("jar")) {
            return getFilesFromJar(resource, dirname);
        } else {
            // 处理文件系统情况
            return getFilesFromFileSystem(resource);
        }
    }

    private static List<String> getFilesFromJar(URL jarUrl, String dirname) throws IOException {
        List<String> fileNames = new ArrayList<>();
        String jarPath = jarUrl.getPath().substring(5, jarUrl.getPath().indexOf("!"));

        try (JarFile jar = new JarFile(jarPath)) {
            jar.entries().asIterator()
                    .forEachRemaining(entry -> {
                        String name = entry.getName();
                        String prefix = dirname + "/";

                        if (name.startsWith(prefix) && !name.endsWith("/")) {
                            fileNames.add(name.substring(prefix.length()));
                        }
                    });
        }

        return fileNames;
    }

    private static List<String> getFilesFromFileSystem(URL resource) throws IOException, URISyntaxException {
        Path filepath = Paths.get(resource.toURI());

        try (Stream<Path> paths = Files.walk(filepath)) {
            return paths.filter(Files::isRegularFile)
                    .map(filepath::relativize)
                    .map(Path::toString)
                    // 统一使用/作为分隔符
                    .map(s -> s.replace('\\', '/'))
                    .toList();
        }
    }
}
