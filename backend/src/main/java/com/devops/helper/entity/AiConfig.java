package com.devops.helper.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("ai_config")
public class AiConfig {

    @TableId
    private Long id;

    private String baseUrl;

    private String apiKey;

    private String model;

    private Integer enabled;
}
