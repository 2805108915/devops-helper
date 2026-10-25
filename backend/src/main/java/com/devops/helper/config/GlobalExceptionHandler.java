package com.devops.helper.config;

import com.devops.helper.common.Result;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public Result<Void> handle(Exception e) {
        log.error("接口异常", e);
        return Result.fail(e.getMessage() == null ? e.getClass().getSimpleName() : e.getMessage());
    }

    /**
     * 404 分流：非 API 的未知路径（Vue history 路由深链）转发到首页，API 返回 JSON。
     */
    @ExceptionHandler(NoResourceFoundException.class)
    public Object handleNoResource(HttpServletRequest request, NoResourceFoundException e) {
        String uri = request.getRequestURI();
        if (uri.startsWith("/api") || uri.startsWith("/ws")) {
            return Result.fail("接口不存在: " + uri);
        }
        return new ModelAndView("forward:/index.html");
    }
}
