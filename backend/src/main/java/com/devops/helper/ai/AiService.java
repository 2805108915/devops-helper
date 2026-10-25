package com.devops.helper.ai;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.entity.AiConfig;
import com.devops.helper.mapper.AiConfigMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * AI 配置管理（OpenAI 兼容接口：GLM / DeepSeek / OpenAI 等）
 */
@Service
@RequiredArgsConstructor
public class AiService {

    private final AiConfigMapper aiConfigMapper;

    public AiConfig getConfig() {
        AiConfig config = aiConfigMapper.selectById(1L);
        if (config == null) {
            config = new AiConfig();
            config.setId(1L);
            config.setEnabled(0);
        }
        return config;
    }

    public AiConfig save(AiConfig config) {
        config.setId(1L);
        if (!StringUtils.hasText(config.getBaseUrl())) {
            throw new IllegalArgumentException("base-url 不能为空");
        }
        if (!StringUtils.hasText(config.getModel())) {
            throw new IllegalArgumentException("模型名不能为空");
        }
        AiConfig exists = aiConfigMapper.selectById(1L);
        if (exists == null) {
            aiConfigMapper.insert(config);
        } else {
            aiConfigMapper.updateById(config);
        }
        return aiConfigMapper.selectById(1L);
    }

    /** 未启用或未配置时返回 null，调用方应优雅降级 */
    public AiConfig requireEnabled() {
        AiConfig c = getConfig();
        if (c.getEnabled() == null || c.getEnabled() != 1
                || !StringUtils.hasText(c.getBaseUrl()) || !StringUtils.hasText(c.getApiKey())) {
            return null;
        }
        return c;
    }
}
