package com.devops.helper.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.devops.helper.entity.KbArticle;
import com.devops.helper.entity.Note;
import com.devops.helper.entity.Question;
import com.devops.helper.entity.ReviewRecord;
import com.devops.helper.mapper.KbArticleMapper;
import com.devops.helper.mapper.NoteMapper;
import com.devops.helper.mapper.QuestionMapper;
import com.devops.helper.mapper.ReviewRecordMapper;
import com.devops.helper.dto.QuestionQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class QuestionService {

    private final QuestionMapper questionMapper;
    private final ReviewRecordMapper reviewRecordMapper;
    private final NoteMapper noteMapper;
    private final KbArticleMapper kbArticleMapper;

    /** 分页查询，附带回填最近复习状态 */
    public Page<Question> page(QuestionQuery q) {
        LambdaQueryWrapper<Question> wrapper = new LambdaQueryWrapper<>();
        if (q.getTopicId() != null) {
            wrapper.eq(Question::getTopicId, q.getTopicId());
        }
        if (StringUtils.hasText(q.getType())) {
            wrapper.eq(Question::getType, q.getType());
        }
        if (q.getDifficulty() != null) {
            wrapper.eq(Question::getDifficulty, q.getDifficulty());
        }
        if (StringUtils.hasText(q.getKeyword())) {
            wrapper.like(Question::getTitle, q.getKeyword().trim());
        }
        if (StringUtils.hasText(q.getPositionCode())) {
            wrapper.apply("JSON_CONTAINS(position_codes, JSON_QUOTE({0}))", q.getPositionCode());
        }
        if (Boolean.TRUE.equals(q.getWrongOnly())) {
            List<Long> wrongIds = reviewRecordMapper.selectList(
                            new LambdaQueryWrapper<ReviewRecord>().lt(ReviewRecord::getQuality, 3))
                    .stream().map(ReviewRecord::getQuestionId).toList();
            if (wrongIds.isEmpty()) {
                return new Page<>(q.getPage(), q.getSize());
            }
            wrapper.in(Question::getId, wrongIds);
        }
        if (Boolean.TRUE.equals(q.getDueOnly())) {
            List<Long> dueIds = reviewRecordMapper.selectList(
                            new LambdaQueryWrapper<ReviewRecord>().le(ReviewRecord::getNextReviewAt, java.time.LocalDateTime.now()))
                    .stream().map(ReviewRecord::getQuestionId).toList();
            if (dueIds.isEmpty()) {
                return new Page<>(q.getPage(), q.getSize());
            }
            wrapper.in(Question::getId, dueIds);
        }
        if ("random".equals(q.getOrder())) {
            wrapper.last("ORDER BY RAND()");
        } else if ("newest".equals(q.getOrder())) {
            wrapper.orderByDesc(Question::getId);
        } else {
            wrapper.orderByDesc(Question::getFrequency).orderByAsc(Question::getId);
        }
        Page<Question> page = questionMapper.selectPage(new Page<>(q.getPage(), q.getSize()), wrapper);
        fillReviewState(page.getRecords());
        return page;
    }

    /** 详情：题目 + 复习状态 + 笔记 + 相关知识库文章 */
    public Map<String, Object> detail(Long id) {
        Question question = questionMapper.selectById(id);
        if (question == null) {
            throw new IllegalArgumentException("题目不存在: " + id);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("question", question);
        result.put("review", reviewRecordMapper.selectOne(
                new LambdaQueryWrapper<ReviewRecord>().eq(ReviewRecord::getQuestionId, id)));
        result.put("note", noteMapper.selectOne(new LambdaQueryWrapper<Note>()
                .eq(Note::getTargetType, "question").eq(Note::getTargetId, id)));
        List<KbArticle> articles = kbArticleMapper.selectList(new LambdaQueryWrapper<KbArticle>()
                .eq(KbArticle::getTopicId, question.getTopicId())
                .orderByDesc(KbArticle::getUpdatedAt));
        result.put("relatedArticles", articles);
        return result;
    }

    /** 为题目列表批量回填最近复习状态（quality / nextReviewAt / reviewCount） */
    public void fillReviewState(List<Question> questions) {
        if (CollectionUtils.isEmpty(questions)) {
            return;
        }
        List<Long> ids = questions.stream().map(Question::getId).toList();
        Map<Long, ReviewRecord> recordMap = new HashMap<>();
        reviewRecordMapper.selectBatchIds(ids).forEach(r -> recordMap.put(r.getQuestionId(), r));
        // Question 实体不含复习字段，用 transient map 由前端合并 → 这里直接改用附加字段
        questions.forEach(q -> {
            ReviewRecord r = recordMap.get(q.getId());
            if (r != null) {
                Map<String, Object> extra = new HashMap<>();
                extra.put("latestQuality", r.getQuality());
                extra.put("nextReviewAt", r.getNextReviewAt());
                extra.put("reviewCount", r.getRepeatCount());
                q.setReviewState(extra);
            }
        });
    }

    public Question create(Question question) {
        if (!StringUtils.hasText(question.getTitle())) {
            throw new IllegalArgumentException("题干不能为空");
        }
        if (question.getTopicId() == null) {
            throw new IllegalArgumentException("必须选择知识点");
        }
        question.setSource(question.getSource() == null ? "自建" : question.getSource());
        question.setId(null);
        questionMapper.insert(question);
        return question;
    }

    public Question update(Question question) {
        if (question.getId() == null || questionMapper.selectById(question.getId()) == null) {
            throw new IllegalArgumentException("题目不存在");
        }
        questionMapper.updateById(question);
        return questionMapper.selectById(question.getId());
    }

    public void delete(Long id) {
        questionMapper.deleteById(id);
        reviewRecordMapper.delete(new LambdaQueryWrapper<ReviewRecord>()
                .eq(ReviewRecord::getQuestionId, id));
        noteMapper.delete(new LambdaQueryWrapper<Note>()
                .eq(Note::getTargetType, "question").eq(Note::getTargetId, id));
    }

    public List<Question> random(Long topicId, int count) {
        QuestionQuery q = new QuestionQuery();
        q.setTopicId(topicId);
        q.setOrder("random");
        q.setSize(count);
        q.setPage(1);
        return page(q).getRecords();
    }

    public List<Question> listByIds(List<Long> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return Collections.emptyList();
        }
        return questionMapper.selectBatchIds(ids);
    }
}
