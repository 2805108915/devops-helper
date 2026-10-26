package com.devops.helper.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.entity.Question;
import com.devops.helper.entity.ReviewLog;
import com.devops.helper.entity.ReviewRecord;
import com.devops.helper.mapper.QuestionMapper;
import com.devops.helper.mapper.ReviewLogMapper;
import com.devops.helper.mapper.ReviewRecordMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * SM-2 间隔重复复习系统（同 Anki）
 * <p>
 * 前端三档自评映射：不会=1，模糊=3，会=5
 */
@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRecordMapper reviewRecordMapper;
    private final ReviewLogMapper reviewLogMapper;
    private final QuestionMapper questionMapper;

    /** 记录一次自评并计算下次复习时间 */
    @Transactional
    public Map<String, Object> review(Long questionId, int quality) {
        if (quality < 0 || quality > 5) {
            throw new IllegalArgumentException("quality 取值 0-5");
        }
        Question question = questionMapper.selectById(questionId);
        if (question == null) {
            throw new IllegalArgumentException("题目不存在: " + questionId);
        }

        ReviewRecord record = reviewRecordMapper.selectOne(
                new LambdaQueryWrapper<ReviewRecord>().eq(ReviewRecord::getQuestionId, questionId));
        boolean isNew = record == null;
        if (isNew) {
            record = new ReviewRecord();
            record.setQuestionId(questionId);
            record.setEaseFactor(2.5);
            record.setIntervalDays(0);
            record.setRepeatCount(0);
        }

        double ef = record.getEaseFactor();
        int repeatCount;
        int intervalDays;
        if (quality < 3) {
            // 不会：重置，明天再见
            repeatCount = 0;
            intervalDays = 1;
        } else {
            repeatCount = record.getRepeatCount() + 1;
            intervalDays = switch (repeatCount) {
                case 1 -> 1;   // 第一次会：明天
                case 2 -> 6;   // 第二次会：6 天后
                default -> Math.max(1, (int) Math.round(record.getIntervalDays() * ef)); // 按难度因子倍增
            };
        }
        // SM-2 难度因子更新
        ef = ef + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
        ef = Math.max(1.3, ef);

        record.setQuality(quality);
        record.setEaseFactor(ef);
        record.setRepeatCount(repeatCount);
        record.setIntervalDays(intervalDays);
        record.setLastReviewed(LocalDateTime.now());
        record.setNextReviewAt(LocalDateTime.now().plusDays(intervalDays));

        if (isNew) {
            reviewRecordMapper.insert(record);
        } else {
            reviewRecordMapper.updateById(record);
        }

        ReviewLog log = new ReviewLog();
        log.setQuestionId(questionId);
        log.setQuality(quality);
        log.setTopicId(question.getTopicId());
        log.setReviewedAt(LocalDateTime.now());
        reviewLogMapper.insert(log);

        Map<String, Object> result = new HashMap<>();
        result.put("intervalDays", intervalDays);
        result.put("nextReviewAt", record.getNextReviewAt());
        return result;
    }

    /** 重置题目为未学（删除复习记录；复习流水保留作为历史） */
    @Transactional
    public void reset(Long questionId) {
        reviewRecordMapper.delete(new LambdaQueryWrapper<ReviewRecord>()
                .eq(ReviewRecord::getQuestionId, questionId));
    }

    /** 今日到期复习队列 */
    public List<Question> todayQueue(int limit) {
        List<ReviewRecord> due = reviewRecordMapper.selectList(
                new LambdaQueryWrapper<ReviewRecord>()
                        .le(ReviewRecord::getNextReviewAt, LocalDateTime.now())
                        .orderByAsc(ReviewRecord::getNextReviewAt)
                        .last("LIMIT " + Math.max(1, limit)));
        if (due.isEmpty()) {
            return List.of();
        }
        List<Long> ids = due.stream().map(ReviewRecord::getQuestionId).toList();
        List<Question> questions = questionMapper.selectBatchIds(ids);
        questions.forEach(q -> {
            ReviewRecord r = due.stream()
                    .filter(d -> d.getQuestionId().equals(q.getId())).findFirst().orElse(null);
            if (r != null) {
                Map<String, Object> state = new HashMap<>();
                state.put("latestQuality", r.getQuality());
                state.put("nextReviewAt", r.getNextReviewAt());
                state.put("reviewCount", r.getRepeatCount());
                q.setReviewState(state);
            }
        });
        return questions;
    }

    /** 仪表盘统计 */
    public Map<String, Object> stats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalQuestions", questionMapper.selectCount(null));
        stats.put("reviewedQuestions", reviewRecordMapper.selectCount(null));
        stats.put("dueToday", reviewRecordMapper.selectCount(
                new LambdaQueryWrapper<ReviewRecord>().le(ReviewRecord::getNextReviewAt, LocalDateTime.now())));
        stats.put("weakCount", reviewRecordMapper.selectCount(
                new LambdaQueryWrapper<ReviewRecord>().lt(ReviewRecord::getQuality, 3)));
        stats.put("topicMastery", reviewLogMapper.topicMastery());
        stats.put("trend", reviewLogMapper.dailyTrend(LocalDateTime.now().minusDays(29)));
        return stats;
    }
}
