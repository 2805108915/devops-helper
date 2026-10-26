package com.devops.helper.controller;

import com.devops.helper.common.Result;
import com.devops.helper.entity.Question;
import com.devops.helper.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/review")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    /** 提交自评：quality 0-5（前端映射 不会=1 模糊=3 会=5） */
    @PostMapping("/{questionId}")
    public Result<Map<String, Object>> review(@PathVariable Long questionId,
                                              @RequestBody Map<String, Integer> body) {
        Integer quality = body.get("quality");
        if (quality == null) {
            return Result.fail("缺少 quality 参数");
        }
        return Result.ok(reviewService.review(questionId, quality));
    }

    /** 重置为未学：删除该题的复习记录 */
    @DeleteMapping("/{questionId}")
    public Result<Void> reset(@PathVariable Long questionId) {
        reviewService.reset(questionId);
        return Result.ok();
    }

    /** 今日到期复习队列 */
    @GetMapping("/today")
    public Result<List<Question>> today(@RequestParam(defaultValue = "50") int limit) {
        return Result.ok(reviewService.todayQueue(limit));
    }

    /** 仪表盘统计 */
    @GetMapping("/stats")
    public Result<Map<String, Object>> stats() {
        return Result.ok(reviewService.stats());
    }
}
