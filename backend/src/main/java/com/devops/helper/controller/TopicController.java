package com.devops.helper.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.common.Result;
import com.devops.helper.entity.KbArticle;
import com.devops.helper.entity.Question;
import com.devops.helper.entity.Topic;
import com.devops.helper.mapper.KbArticleMapper;
import com.devops.helper.mapper.QuestionMapper;
import com.devops.helper.mapper.TopicMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/topics")
@RequiredArgsConstructor
public class TopicController {

    private final TopicMapper topicMapper;
    private final KbArticleMapper kbArticleMapper;
    private final QuestionMapper questionMapper;

    @GetMapping
    public Result<List<Topic>> list() {
        return Result.ok(topicMapper.selectList(
                new LambdaQueryWrapper<Topic>().orderByAsc(Topic::getSortOrder)));
    }

    /** 新增知识库自定义分组 */
    @PostMapping
    public Result<Topic> create(@RequestBody Map<String, String> body) {
        String name = body.get("name");
        if (!StringUtils.hasText(name) || name.trim().length() > 50) {
            return Result.fail("分组名不能为空且不超过50字");
        }
        Long exists = topicMapper.selectCount(
                new LambdaQueryWrapper<Topic>().eq(Topic::getName, name.trim()));
        if (exists > 0) {
            return Result.fail("分组名已存在: " + name.trim());
        }
        Topic topic = new Topic();
        topic.setName(name.trim());
        topic.setCode("custom-" + System.currentTimeMillis());
        topic.setDescription("自定义分组");
        topic.setBuiltin(0);
        topic.setSortOrder(100);
        topicMapper.insert(topic);
        return Result.ok(topic);
    }

    /** 删除自定义分组（内置知识点与有内容的分组不可删） */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        Topic topic = topicMapper.selectById(id);
        if (topic == null) {
            return Result.fail("分组不存在");
        }
        if (topic.getBuiltin() != null && topic.getBuiltin() == 1) {
            return Result.fail("内置知识点不可删除");
        }
        Long articles = kbArticleMapper.selectCount(
                new LambdaQueryWrapper<KbArticle>().eq(KbArticle::getTopicId, id));
        if (articles > 0) {
            return Result.fail("分组下还有 " + articles + " 篇文章，请先删除或移动文章");
        }
        Long questions = questionMapper.selectCount(
                new LambdaQueryWrapper<Question>().eq(Question::getTopicId, id));
        if (questions > 0) {
            return Result.fail("分组下还有 " + questions + " 道题目，无法删除");
        }
        topicMapper.deleteById(id);
        return Result.ok();
    }
}
