package com.devops.helper.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.devops.helper.entity.ReviewLog;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public interface ReviewLogMapper extends BaseMapper<ReviewLog> {

    /** 近 N 天每日复习量趋势 */
    @Select("SELECT DATE(reviewed_at) AS date, COUNT(*) AS count FROM review_log " +
            "WHERE reviewed_at >= #{since} GROUP BY DATE(reviewed_at) ORDER BY date")
    List<Map<String, Object>> dailyTrend(LocalDateTime since);

    /** 各知识点掌握统计：题目总数 / 已学 / 掌握(quality>=4) / 生疏(quality<3) */
    @Select("SELECT t.id AS topicId, t.name AS topicName, " +
            "COUNT(q.id) AS total, " +
            "SUM(CASE WHEN r.question_id IS NOT NULL THEN 1 ELSE 0 END) AS learned, " +
            "SUM(CASE WHEN r.quality >= 4 THEN 1 ELSE 0 END) AS mastered, " +
            "SUM(CASE WHEN r.quality < 3 THEN 1 ELSE 0 END) AS weak, " +
            "AVG(r.quality) AS avgQuality " +
            "FROM topic t LEFT JOIN question q ON q.topic_id = t.id " +
            "LEFT JOIN review_record r ON q.id = r.question_id " +
            "GROUP BY t.id, t.name ORDER BY t.sort_order")
    List<Map<String, Object>> topicMastery();
}
