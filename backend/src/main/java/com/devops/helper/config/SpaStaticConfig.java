package com.devops.helper.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;

import java.io.File;
import java.net.URI;
import java.util.List;

/**
 * 托管前端构建产物（frontend/dist）：一键启动时无需独立前端进程。
 * Vue history 路由刷新回退到 index.html；/api、/ws 仍由 Controller 与 WebSocket 处理。
 */
@Slf4j
@Configuration
public class SpaStaticConfig implements WebMvcConfigurer {

    @Value("${static-front-dir:}")
    private String configured;

    private File frontDir() {
        // 1. 显式配置优先
        if (!configured.isBlank()) {
            File dir = new File(configured);
            return new File(dir, "index.html").exists() ? dir : null;
        }
        // 2. 从 jar/classes 位置向上反推（与启动时工作目录无关，双击快捷方式也稳定）
        File dir = fromCodeSource();
        if (dir != null) {
            return dir;
        }
        // 3. 兜底：按工作目录探测
        for (String c : List.of("./frontend/dist", "../frontend/dist")) {
            File d = new File(c);
            if (new File(d, "index.html").exists()) {
                return d;
            }
        }
        return null;
    }

    /** 代码源在 .../backend/target/ 下，逐级向上找 frontend/dist */
    private File fromCodeSource() {
        try {
            File codeSource = new File(SpaStaticConfig.class.getProtectionDomain()
                    .getCodeSource().getLocation().toURI());
            File cur = codeSource.getParentFile();
            for (int i = 0; i < 5 && cur != null; i++) {
                File candidate = new File(cur, "frontend/dist");
                if (new File(candidate, "index.html").exists()) {
                    return candidate;
                }
                cur = cur.getParentFile();
            }
        } catch (Exception ignored) {
        }
        return null;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        File dir = frontDir();
        if (dir == null) {
            log.info("未找到前端 dist 目录（开发模式可继续用 Vite 5173）");
            return;
        }
        log.info("托管前端静态资源: {}", dir.getAbsolutePath());
        String location = dir.toURI().toString();
        registry.addResourceHandler("/**")
                .addResourceLocations(location)
                .resourceChain(true)
                .addResolver(new PathResourceResolver() {
                    @Override
                    protected Resource getResource(String resourcePath, Resource location) throws java.io.IOException {
                        Resource requested = super.getResource(resourcePath, location);
                        // SPA 路由回退：非静态资源请求统一回 index.html
                        return requested != null ? requested
                                : new FileSystemResource(new File(dir, "index.html"));
                    }
                });
    }
}
