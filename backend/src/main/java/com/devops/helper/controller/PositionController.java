package com.devops.helper.controller;

import com.devops.helper.common.Result;
import com.devops.helper.service.PositionService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/positions")
@RequiredArgsConstructor
public class PositionController {

    private final PositionService positionService;

    @GetMapping
    public Result<List<Map<String, Object>>> list() {
        return Result.ok(positionService.listWithStats());
    }
}
