package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@TableName(value = "position", autoResultMap = true)
public class Position {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String code;

    private String name;

    private String description;

    /** 技能路线图 [{stage, items[]}] */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<Map<String, Object>> skills;

    private Integer sortOrder;
}
