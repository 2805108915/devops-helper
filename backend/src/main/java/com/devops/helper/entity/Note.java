package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("note")
public class Note {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** question / lab / topic */
    private String targetType;

    private Long targetId;

    private String content;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
