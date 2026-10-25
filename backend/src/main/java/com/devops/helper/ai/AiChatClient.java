package com.devops.helper.ai;

import com.devops.helper.entity.AiConfig;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.List;
import java.util.Map;

/**
 * OpenAI 兼容 /chat/completions 流式调用（SSE → SseEmitter）
 */
@Slf4j
@Component
public class AiChatClient {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(15))
            .build();

    public void streamChat(AiConfig config,
                           List<Map<String, String>> messages,
                           Double temperature,
                           SseEmitter emitter) {
        ObjectNode body = objectMapper.createObjectNode();
        body.put("model", config.getModel());
        body.put("stream", true);
        if (temperature != null) {
            body.put("temperature", temperature);
        }
        ArrayNode msgArray = body.putArray("messages");
        messages.forEach(m -> {
            ObjectNode node = msgArray.addObject();
            node.put("role", m.get("role"));
            node.put("content", m.get("content"));
        });

        String url = config.getBaseUrl().replaceAll("/+$", "") + "/chat/completions";
        new Thread(() -> {
            try {
                HttpRequest request = HttpRequest.newBuilder()
                        .uri(URI.create(url))
                        .header("Content-Type", "application/json")
                        .header("Authorization", "Bearer " + config.getApiKey())
                        .timeout(Duration.ofMinutes(5))
                        .POST(HttpRequest.BodyPublishers.ofString(
                                objectMapper.writeValueAsString(body), StandardCharsets.UTF_8))
                        .build();

                HttpResponse<java.io.InputStream> response = httpClient.send(request,
                        HttpResponse.BodyHandlers.ofInputStream());
                if (response.statusCode() != 200) {
                    String err = new String(response.body().readAllBytes(), StandardCharsets.UTF_8);
                    emitter.send(SseEmitter.event().name("error").data("API 返回 " + response.statusCode() + ": " + err));
                    emitter.complete();
                    return;
                }
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(response.body(), StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        if (!line.startsWith("data:")) {
                            continue;
                        }
                        String data = line.substring(5).trim();
                        if ("[DONE]".equals(data)) {
                            break;
                        }
                        JsonNode root = objectMapper.readTree(data);
                        JsonNode delta = root.path("choices").path(0).path("delta").path("content");
                        if (!delta.isMissingNode() && !delta.isNull() && !delta.asText().isEmpty()) {
                            emitter.send(SseEmitter.event().name("message").data(delta.asText()));
                        }
                    }
                }
                emitter.send(SseEmitter.event().name("done").data(""));
                emitter.complete();
            } catch (Exception e) {
                log.error("AI 流式调用失败", e);
                try {
                    emitter.send(SseEmitter.event().name("error").data("调用失败: " + e.getMessage()));
                } catch (Exception ignored) {
                }
                emitter.complete();
            }
        }, "ai-chat").start();
    }
}
