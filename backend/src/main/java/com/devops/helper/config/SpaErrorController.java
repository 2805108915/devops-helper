package com.devops.helper.config;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

/**
 * 兜底 /error：浏览器访问不存在的非 API 路径时回退到 SPA 首页（history 路由刷新支持）。
 */
@RestController
public class SpaErrorController implements ErrorController {

    @RequestMapping("/error")
    public Object handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        String uri = String.valueOf(request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI));
        int code = status == null ? 500 : Integer.parseInt(status.toString());
        if (code == HttpStatus.NOT_FOUND.value() && !uri.startsWith("/api") && !uri.startsWith("/ws")) {
            return new ModelAndView("forward:/index.html");
        }
        return "{\"code\":1,\"msg\":\"HTTP " + code + " at " + uri + "\"}";
    }
}
