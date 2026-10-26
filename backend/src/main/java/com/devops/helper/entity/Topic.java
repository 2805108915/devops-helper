package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("topic")
public class Topic {

    @TableId(type = IdType.AUTO)
    private Long id;

    private Long parentId;

    private String code;

    private String name;

    private String description;

    private String icon;

    private Integer sortOrder;

    /** 1=内置知识点(不可删除) 0=用户自建分组 */
    private Integer builtin;
}
