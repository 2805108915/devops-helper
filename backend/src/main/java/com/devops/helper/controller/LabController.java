package com.devops.helper.controller;

import com.devops.helper.common.Result;
import com.devops.helper.entity.Lab;
import com.devops.helper.entity.LabInstance;
import com.devops.helper.lab.LabContainerManager;
import com.devops.helper.service.LabService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/labs")
@RequiredArgsConstructor
public class LabController {

    private final LabService labService;
    private final LabContainerManager containerManager;

    @Value("${lab.image-context:../labs/images/base}")
    private String imageContext;

    @GetMapping
    public Result<List<Map<String, Object>>> list() {
        return Result.ok(labService.listWithRuntime());
    }

    @GetMapping("/{id}")
    public Result<Lab> detail(@PathVariable Long id) {
        return Result.ok(labService.detail(id));
    }

    /** 开始实验：创建沙箱容器并预埋故障 */
    @PostMapping("/{id}/instances")
    public Result<LabInstance> start(@PathVariable Long id) {
        return Result.ok(labService.start(id));
    }

    @PostMapping("/build-image")
    public Result<String> buildImage() {
        return Result.ok("镜像构建成功: " + labService.buildBaseImage(imageContext));
    }

    @GetMapping("/docker-status")
    public Result<Map<String, Object>> dockerStatus() {
        Map<String, Object> status = new java.util.HashMap<>();
        try {
            status.put("available", true);
            status.put("version", containerManager.dockerVersion());
            status.put("imageReady", containerManager.imageExists());
        } catch (Exception e) {
            status.put("available", false);
            status.put("error", "Docker 不可用: " + e.getMessage());
        }
        return Result.ok(status);
    }
}
