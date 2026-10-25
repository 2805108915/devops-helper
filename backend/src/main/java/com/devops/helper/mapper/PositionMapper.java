package com.devops.helper.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.devops.helper.entity.Position;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface PositionMapper extends BaseMapper<Position> {

    @Select("SELECT COUNT(*) FROM question WHERE JSON_CONTAINS(position_codes, JSON_QUOTE(#{code}))")
    int countQuestions(String code);

    @Select("SELECT COUNT(*) FROM question q JOIN review_record r ON q.id = r.question_id " +
            "WHERE JSON_CONTAINS(q.position_codes, JSON_QUOTE(#{code}))")
    int countReviewed(String code);
}
