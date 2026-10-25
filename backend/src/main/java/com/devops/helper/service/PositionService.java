package com.devops.helper.service;

import com.devops.helper.entity.Position;
import com.devops.helper.mapper.PositionMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PositionService {

    private final PositionMapper positionMapper;

    /** 全部岗位 + 题量/已学统计 */
    public List<Map<String, Object>> listWithStats() {
        return positionMapper.selectList(
                        new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Position>()
                                .orderByAsc(Position::getSortOrder))
                .stream().map(p -> {
                    Map<String, Object> item = new HashMap<>();
                    item.put("position", p);
                    item.put("totalQuestions", positionMapper.countQuestions(p.getCode()));
                    item.put("reviewedQuestions", positionMapper.countReviewed(p.getCode()));
                    return item;
                }).toList();
    }
}
