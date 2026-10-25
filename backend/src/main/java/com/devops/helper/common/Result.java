package com.devops.helper.common;

import lombok.Data;

/**
 * 统一响应包装
 */
@Data
public class Result<T> {

    private int code;       // 0 成功，非 0 失败
    private String msg;
    private T data;

    public static <T> Result<T> ok(T data) {
        Result<T> r = new Result<>();
        r.code = 0;
        r.msg = "ok";
        r.data = data;
        return r;
    }

    public static Result<Void> ok() {
        return ok(null);
    }

    public static <T> Result<T> fail(String msg) {
        Result<T> r = new Result<>();
        r.code = 1;
        r.msg = msg;
        return r;
    }
}
