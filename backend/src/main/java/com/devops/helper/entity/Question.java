package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
@TableName(value = "question", autoResultMap = true)
public class Question {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long topicId;

    /** QA 问答 / SCENARIO 场景 / CHOICE 选择 */
    private String type;

    /** 1 初级 2 中级 3 高级 */
    private Integer difficulty;

    private String title;

    private String content;

    /** 选择题选项 */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> options;

    private String answer;

    /** 追问列表 */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> followUps;

    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> tags;

    /** 面试出现频率 1-5 */
    private Integer frequency;

    /** 适用岗位编码 */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> positionCodes;

    private String source;

    private Long userId;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    /** 非数据库字段：最近复习状态（latestQuality/nextReviewAt/reviewCount） */
    @TableField(exist = false)
    private Map<String, Object> reviewState;
}
