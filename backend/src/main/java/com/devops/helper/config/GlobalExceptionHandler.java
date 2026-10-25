package com.devops.helper.config;

import com.devops.helper.common.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public Result<Void> handle(Exception e) {
        log.error("接口异常", e);
        return Result.fail(e.getMessage() == null ? e.getClass().getSimpleName() : e.getMessage());
    }
}
