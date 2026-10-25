package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("review_record")
public class ReviewRecord {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long questionId;

    /** 最近一次评分 0-5 */
    private Integer quality;

    private Double easeFactor;

    private Integer intervalDays;

    private Integer repeatCount;

    private LocalDateTime nextReviewAt;

    private LocalDateTime lastReviewed;
}
