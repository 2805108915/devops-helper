package com.devops.helper.controller;

import com.devops.helper.common.Result;
import com.devops.helper.entity.KbArticle;
import com.devops.helper.entity.KbArticleHistory;
import com.devops.helper.service.KbService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/kb")
@RequiredArgsConstructor
public class KbController {

    private final KbService kbService;

    @GetMapping
    public Result<List<KbArticle>> list(@RequestParam(required = false) Long topicId,
                                         @RequestParam(required = false) String keyword) {
        return Result.ok(kbService.list(topicId, keyword));
    }

    @GetMapping("/{id}")
    public Result<Map<String, Object>> detail(@PathVariable Long id) {
        return Result.ok(kbService.detail(id));
    }

    @PostMapping
    public Result<KbArticle> create(@RequestBody KbArticle article) {
        return Result.ok(kbService.create(article));
    }

    @PutMapping("/{id}")
    public Result<KbArticle> update(@PathVariable Long id, @RequestBody KbArticle article) {
        article.setId(id);
        return Result.ok(kbService.update(article));
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        kbService.delete(id);
        return Result.ok();
    }

    /** 修改历史列表（新→旧） */
    @GetMapping("/{id}/history")
    public Result<List<KbArticleHistory>> history(@PathVariable Long id) {
        return Result.ok(kbService.history(id));
    }

    /** 回滚到指定历史版本（当前版本会先被存档，回滚可撤销） */
    @PostMapping("/{id}/history/{historyId}/restore")
    public Result<KbArticle> restore(@PathVariable Long id, @PathVariable Long historyId) {
        return Result.ok(kbService.restore(id, historyId));
    }
}
