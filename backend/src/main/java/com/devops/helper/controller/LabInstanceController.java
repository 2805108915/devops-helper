package com.devops.helper.controller;

import com.devops.helper.common.Result;
import com.devops.helper.entity.LabInstance;
import com.devops.helper.service.LabService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/lab-instances")
@RequiredArgsConstructor
public class LabInstanceController {

    private final LabService labService;

    @GetMapping("/{id}")
    public Result<LabInstance> get(@PathVariable Long id) {
        return Result.ok(labService.getInstance(id));
    }

    /** 运行检测脚本判分 */
    @PostMapping("/{id}/check")
    public Result<Map<String, Object>> check(@PathVariable Long id) {
        return Result.ok(labService.check(id));
    }

    /** 主动销毁容器 */
    @PostMapping("/{id}/stop")
    public Result<Void> stop(@PathVariable Long id) {
        labService.stop(id);
        return Result.ok();
    }
}
