package com.devops.helper.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.devops.helper.common.Result;
import com.devops.helper.dto.QuestionQuery;
import com.devops.helper.entity.Question;
import com.devops.helper.service.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/questions")
@RequiredArgsConstructor
public class QuestionController {

    private final QuestionService questionService;

    @GetMapping
    public Result<Page<Question>> page(QuestionQuery query) {
        return Result.ok(questionService.page(query));
    }

    @GetMapping("/{id}")
    public Result<Map<String, Object>> detail(@PathVariable Long id) {
        return Result.ok(questionService.detail(id));
    }

    @PostMapping
    public Result<Question> create(@RequestBody Question question) {
        return Result.ok(questionService.create(question));
    }

    @PutMapping("/{id}")
    public Result<Question> update(@PathVariable Long id, @RequestBody Question question) {
        question.setId(id);
        return Result.ok(questionService.update(question));
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        questionService.delete(id);
        return Result.ok();
    }

    /** 随机抽题（快速自测） */
    @GetMapping("/random")
    public Result<List<Question>> random(@RequestParam(required = false) Long topicId,
                                         @RequestParam(defaultValue = "10") int count) {
        return Result.ok(questionService.random(topicId, Math.min(Math.max(count, 1), 50)));
    }
}
