package com.devops.helper.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.entity.KbArticle;
import com.devops.helper.entity.KbArticleHistory;
import com.devops.helper.entity.Question;
import com.devops.helper.mapper.KbArticleHistoryMapper;
import com.devops.helper.mapper.KbArticleMapper;
import com.devops.helper.mapper.QuestionMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class KbService {

    private final KbArticleMapper kbArticleMapper;
    private final KbArticleHistoryMapper historyMapper;
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
        // 修改历史（新→旧），只带时间与标题，正文按需查看
        result.put("historyCount", historyMapper.selectCount(
                new LambdaQueryWrapper<KbArticleHistory>().eq(KbArticleHistory::getArticleId, id)));
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

    /**
     * 更新文章：把被替换的旧版本完整快照存入历史表（修改时间记录永不丢失）
     */
    @Transactional
    public KbArticle update(KbArticle article) {
        if (article.getId() == null) {
            throw new IllegalArgumentException("缺少文章 id");
        }
        KbArticle old = kbArticleMapper.selectById(article.getId());
        if (old == null) {
            throw new IllegalArgumentException("文章不存在");
        }
        if (!StringUtils.hasText(article.getTitle())) {
            throw new IllegalArgumentException("标题不能为空");
        }
        // 内容或标题有实际变化才存档，避免无意义快照
        boolean changed = !java.util.Objects.equals(old.getTitle(), article.getTitle())
                || !java.util.Objects.equals(old.getContentMd(), article.getContentMd())
                || !java.util.Objects.equals(old.getTopicId(), article.getTopicId());
        if (changed) {
            KbArticleHistory snap = new KbArticleHistory();
            snap.setArticleId(old.getId());
            snap.setTitle(old.getTitle());
            snap.setContentMd(old.getContentMd());
            historyMapper.insert(snap);
        }
        kbArticleMapper.updateById(article);
        return kbArticleMapper.selectById(article.getId());
    }

    /** 某文章的历史版本列表（新→旧） */
    public List<KbArticleHistory> history(Long articleId) {
        return historyMapper.selectList(new LambdaQueryWrapper<KbArticleHistory>()
                .eq(KbArticleHistory::getArticleId, articleId)
                .orderByDesc(KbArticleHistory::getId));
    }

    /** 回滚到某个历史版本：先把当前版本存档，再恢复指定快照内容 */
    @Transactional
    public KbArticle restore(Long articleId, Long historyId) {
        KbArticleHistory snap = historyMapper.selectById(historyId);
        if (snap == null || !snap.getArticleId().equals(articleId)) {
            throw new IllegalArgumentException("历史版本不存在");
        }
        KbArticle current = kbArticleMapper.selectById(articleId);
        if (current == null) {
            throw new IllegalArgumentException("文章不存在");
        }
        // 当前版本也先存档，保证回滚本身可撤销
        KbArticleHistory curSnap = new KbArticleHistory();
        curSnap.setArticleId(articleId);
        curSnap.setTitle(current.getTitle());
        curSnap.setContentMd(current.getContentMd());
        historyMapper.insert(curSnap);

        current.setTitle(snap.getTitle());
        current.setContentMd(snap.getContentMd());
        kbArticleMapper.updateById(current);
        return current;
    }

    /** 删除文章：连同历史版本一起清理 */
    @Transactional
    public void delete(Long id) {
        kbArticleMapper.deleteById(id);
        historyMapper.delete(new LambdaQueryWrapper<KbArticleHistory>()
                .eq(KbArticleHistory::getArticleId, id));
    }
}
