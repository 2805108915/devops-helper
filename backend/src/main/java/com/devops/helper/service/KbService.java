package com.devops.helper.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.entity.KbArticle;
import com.devops.helper.entity.Question;
import com.devops.helper.mapper.KbArticleMapper;
import com.devops.helper.mapper.QuestionMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class KbService {

    private final KbArticleMapper kbArticleMapper;
    private final QuestionMapper questionMapper;

    public List<KbArticle> list(Long topicId, String keyword) {
        LambdaQueryWrapper<KbArticle> wrapper = new LambdaQueryWrapper<>();
        if (topicId != null) {
            wrapper.eq(KbArticle::getTopicId, topicId);
        }
        if (StringUtils.hasText(keyword)) {
            wrapper.and(w -> w.like(KbArticle::getTitle, keyword.trim())
                    .or().like(KbArticle::getContentMd, keyword.trim()));
        }
        wrapper.orderByDesc(KbArticle::getUpdatedAt);
        return kbArticleMapper.selectList(wrapper);
    }

    public Map<String, Object> detail(Long id) {
        KbArticle article = kbArticleMapper.selectById(id);
        if (article == null) {
            throw new IllegalArgumentException("文章不存在: " + id);
        }
        Map<String, Object> result = new HashMap<>();
        result.put("article", article);
        List<Long> qids = article.getQuestionIds();
        result.put("questions",
                (qids == null || qids.isEmpty()) ? List.of() : questionMapper.selectBatchIds(qids));
        return result;
    }

    public KbArticle create(KbArticle article) {
        if (!StringUtils.hasText(article.getTitle())) {
            throw new IllegalArgumentException("标题不能为空");
        }
        article.setId(null);
        kbArticleMapper.insert(article);
        return article;
    }

    public KbArticle update(KbArticle article) {
        if (article.getId() == null || kbArticleMapper.selectById(article.getId()) == null) {
            throw new IllegalArgumentException("文章不存在");
        }
        kbArticleMapper.updateById(article);
        return kbArticleMapper.selectById(article.getId());
    }

    public void delete(Long id) {
        kbArticleMapper.deleteById(id);
    }
}
