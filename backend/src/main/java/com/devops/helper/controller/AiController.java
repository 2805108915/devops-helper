package com.devops.helper.controller;

import com.devops.helper.ai.AiChatClient;
import com.devops.helper.ai.AiService;
import com.devops.helper.common.Result;
import com.devops.helper.entity.AiConfig;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
public class AiController {

    private final AiService aiService;
    private final AiChatClient aiChatClient;

    @GetMapping("/config")
    public Result<AiConfig> getConfig() {
        return Result.ok(aiService.getConfig());
    }

    @PutMapping("/config")
    public Result<AiConfig> saveConfig(@RequestBody AiConfig config) {
        return Result.ok(aiService.save(config));
    }

    /**
     * 流式对话（SSE）。前端负责拼 system prompt（模拟面试官/追问/生成题目等场景）。
     * body: { messages: [{role, content}], temperature?: number }
     */
    @PostMapping(value = "/chat", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter chat(@RequestBody ChatRequest body) {
        AiConfig config = aiService.requireEnabled();
        SseEmitter emitter = new SseEmitter(5 * 60_000L);
        if (config == null) {
            try {
                emitter.send(SseEmitter.event().name("error")
                        .data("AI 未启用，请先在设置中配置 base-url / api-key 并启用"));
                emitter.complete();
            } catch (Exception ignored) {
            }
            return emitter;
        }
        aiChatClient.streamChat(config, body.getMessages(), body.getTemperature(), emitter);
        return emitter;
    }

    @Data
    public static class ChatRequest {
        private List<Map<String, String>> messages;
        private Double temperature;
    }
}
