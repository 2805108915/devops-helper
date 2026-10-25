package com.devops.helper.dto;

import lombok.Data;

@Data
public class QuestionQuery {

    private Long topicId;
    private String type;          // QA / SCENARIO / CHOICE
    private Integer difficulty;   // 1-3
    private String keyword;       // 标题关键词
    private String positionCode;  // 岗位编码
    private Boolean wrongOnly;    // 只看错题（最近一次评分 < 3）
    private Boolean dueOnly;      // 只看到期该复习的
    private String order;         // frequency(默认) / random / newest
    private long page = 1;
    private long size = 20;
}
