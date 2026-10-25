package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Map;

@Data
@TableName(value = "lab_instance", autoResultMap = true)
public class LabInstance {

    public static final String STATUS_CREATED = "CREATED";
    public static final String STATUS_RUNNING = "RUNNING";
    public static final String STATUS_EXPIRED = "EXPIRED";
    public static final String STATUS_DESTROYED = "DESTROYED";
    public static final String STATUS_COMPLETED = "COMPLETED";

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long labId;

    private String containerId;

    private String status;

    private Integer score;

    /** 判分明细 */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private Map<String, Object> checkResult;

    private LocalDateTime startedAt;

    private LocalDateTime expiredAt;

    private LocalDateTime finishedAt;
}
