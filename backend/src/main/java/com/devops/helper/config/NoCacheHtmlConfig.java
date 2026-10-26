package com.devops.helper.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.filter.OncePerRequestFilter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * index.html 禁缓存：SPA 入口若被浏览器启发式缓存，发布新版本后用户会一直看到旧页面。
 * JS/CSS 文件名带内容哈希可放心长缓存，唯独 index.html 必须每次回源校验。
 */
@Configuration
public class NoCacheHtmlConfig {

    @Bean
    public FilterRegistrationBean<OncePerRequestFilter> noCacheHtmlFilter() {
        FilterRegistrationBean<OncePerRequestFilter> reg = new FilterRegistrationBean<>();
        reg.setFilter(new OncePerRequestFilter() {
            @Override
            protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                            FilterChain chain) throws ServletException, IOException {
                String path = request.getRequestURI();
                if ("/".equals(path) || path.endsWith("/index.html")) {
                    response.setHeader("Cache-Control", "no-cache, max-age=0, must-revalidate");
                }
                chain.doFilter(request, response);
            }
        });
        reg.addUrlPatterns("/*");
        reg.setOrder(Ordered.HIGHEST_PRECEDENCE + 10);
        return reg;
    }
}
