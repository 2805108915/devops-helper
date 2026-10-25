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
@TableName(value = "kb_article", autoResultMap = true)
public class KbArticle {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long topicId;

    private String title;

    private String contentMd;

    /** 关联题目 id */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<Long> questionIds;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
