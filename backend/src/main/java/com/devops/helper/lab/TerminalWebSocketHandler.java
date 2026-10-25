package com.devops.helper.lab;

import com.devops.helper.entity.LabInstance;
import com.devops.helper.mapper.LabInstanceMapper;
import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.async.ResultCallback;
import com.github.dockerjava.api.command.AttachContainerCmd;
import com.github.dockerjava.api.model.Frame;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import java.io.IOException;
import java.io.PipedInputStream;
import java.io.PipedOutputStream;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Web 终端桥接：浏览器 xterm.js ↔ WebSocket ↔ docker attach（stdin/stdout）
 * URL: ws://localhost:8080/ws/lab-terminal/{instanceId}
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class TerminalWebSocketHandler extends BinaryWebSocketHandler {

    private final DockerClient dockerClient;
    private final LabInstanceMapper labInstanceMapper;

    /** wsSessionId -> 终端会话资源，用于断开时释放 */
    private final Map<String, TerminalSession> sessions = new ConcurrentHashMap<>();

    private static class TerminalSession {
        PipedOutputStream stdin;
        PipedInputStream stdinPipe;
        ResultCallback.Adapter<Frame> callback;
        WebSocketSession ws;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession ws) throws Exception {
        String path = ws.getUri() != null ? ws.getUri().getPath() : "";
        String instanceId = path.substring(path.lastIndexOf('/') + 1);
        LabInstance instance = labInstanceMapper.selectById(Long.valueOf(instanceId));
        if (instance == null || !LabInstance.STATUS_RUNNING.equals(instance.getStatus())
                || instance.getContainerId() == null) {
            ws.close(new CloseStatus(4000, "实验实例不可用或已过期，请重新开始实验"));
            return;
        }

        TerminalSession ts = new TerminalSession();
        ts.ws = ws;
        ts.stdinPipe = new PipedInputStream(64 * 1024);
        ts.stdin = new PipedOutputStream(ts.stdinPipe);
        sessions.put(ws.getId(), ts);

        try {
            AttachContainerCmd attach = dockerClient.attachContainerCmd(instance.getContainerId())
                    .withFollowStream(true)
                    .withStdIn(ts.stdinPipe)
                    .withStdOut(true)
                    .withStdErr(true)
                    .withTimestamps(false);
            ts.callback = attach.exec(new ResultCallback.Adapter<Frame>() {
                @Override
                public void onNext(Frame frame) {
                    try {
                        if (ws.isOpen()) {
                            synchronized (ws) {
                                ws.sendMessage(new BinaryMessage(frame.getPayload()));
                            }
                        } else {
                            throw new IllegalStateException("WebSocket 已关闭");
                        }
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }

                @Override
                public void onComplete() {
                    closeQuietly(ws, new CloseStatus(1000, "终端会话已结束（容器主进程退出）"));
                }
            });
            // 欢迎提示
            byte[] welcome = "\r\n\u001b[1;34m[DevOpsHelper 实验终端]\u001b[0m 输入命令开始排查，完成后回到页面点击「检测」。\r\n\r\n"
                    .getBytes(StandardCharsets.UTF_8);
            synchronized (ws) {
                ws.sendMessage(new BinaryMessage(welcome));
            }
        } catch (Exception e) {
            log.error("attach 容器失败", e);
            sessions.remove(ws.getId());
            ws.close(new CloseStatus(1011, "连接容器失败: " + e.getMessage()));
        }
    }

    @Override
    protected void handleBinaryMessage(WebSocketSession ws, BinaryMessage message) {
        TerminalSession ts = sessions.get(ws.getId());
        if (ts != null) {
            ByteBuffer buf = message.getPayload();
            byte[] bytes = new byte[buf.remaining()];
            buf.get(bytes);
            try {
                ts.stdin.write(bytes);
                ts.stdin.flush();
            } catch (IOException e) {
                log.warn("写入容器 stdin 失败: {}", e.getMessage());
            }
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession ws, TextMessage message) {
        TerminalSession ts = sessions.get(ws.getId());
        if (ts != null) {
            try {
                ts.stdin.write(message.getPayload().getBytes(StandardCharsets.UTF_8));
                ts.stdin.flush();
            } catch (IOException e) {
                log.warn("写入容器 stdin 失败: {}", e.getMessage());
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession ws, CloseStatus status) {
        TerminalSession ts = sessions.remove(ws.getId());
        if (ts != null) {
            try {
                if (ts.callback != null) {
                    ts.callback.close();
                }
            } catch (IOException e) {
                log.debug("关闭 attach 回调失败: {}", e.getMessage());
            }
            try {
                ts.stdin.close();
                ts.stdinPipe.close();
            } catch (IOException ignored) {
            }
        }
    }

    private void closeQuietly(WebSocketSession ws, CloseStatus status) {
        try {
            if (ws.isOpen()) {
                ws.close(status);
            }
        } catch (IOException ignored) {
        }
    }
}
