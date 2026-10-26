package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("kb_article_history")
public class KbArticleHistory {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long articleId;

    private String title;

    private String contentMd;

    /** 该版本被存档（被新版替换）的时间 */
    private LocalDateTime savedAt;
}
