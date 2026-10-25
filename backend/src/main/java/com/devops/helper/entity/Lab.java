package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@TableName(value = "lab", autoResultMap = true)
public class Lab {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String code;

    private String name;

    private Long topicId;

    private Integer difficulty;

    private String scenario;

    private String image;

    private String setupScript;

    private String checkScript;

    /** 分级提示 */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> hints;

    private String solution;

    private Integer timeLimitMinutes;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> tags;

    private Integer sortOrder;

    private LocalDateTime createdAt;
}
