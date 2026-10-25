package com.devops.helper.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.common.Result;
import com.devops.helper.entity.Topic;
import com.devops.helper.mapper.TopicMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/topics")
@RequiredArgsConstructor
public class TopicController {

    private final TopicMapper topicMapper;

    @GetMapping
    public Result<List<Topic>> list() {
        return Result.ok(topicMapper.selectList(
                new LambdaQueryWrapper<Topic>().orderByAsc(Topic::getSortOrder)));
    }
}
