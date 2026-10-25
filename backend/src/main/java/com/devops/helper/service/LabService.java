package com.devops.helper.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.entity.Lab;
import com.devops.helper.entity.LabInstance;
import com.devops.helper.entity.Topic;
import com.devops.helper.lab.LabContainerManager;
import com.devops.helper.mapper.LabInstanceMapper;
import com.devops.helper.mapper.LabMapper;
import com.devops.helper.mapper.TopicMapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.File;
import java.time.LocalDateTime;
import java.util.*;

/**
 * Lab 业务：定义加载、实例生命周期、判分、过期清理
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class LabService {

    private final LabMapper labMapper;
    private final LabInstanceMapper labInstanceMapper;
    private final TopicMapper topicMapper;
    private final LabContainerManager containerManager;
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Value("${lab.defs-dir:../labs/definitions}")
    private String defsDir;

    /**
     * 相对路径自适应：从项目根启动（java -jar）或 backend/ 启动（IDE、mvn）都能找到 labs 目录
     */
    private File resolveDir(String configured, String tail) {
        File f = new File(configured);
        if (f.isDirectory()) {
            return f;
        }
        for (String candidate : new String[]{"labs/" + tail, "../labs/" + tail}) {
            File c = new File(candidate);
            if (c.isDirectory()) {
                return c;
            }
        }
        return f;
    }

    /** 启动时加载 labs/definitions/*.yml 并 upsert */
    public void loadDefinitions() {
        File dir = resolveDir(defsDir, "definitions");
        if (!dir.isDirectory()) {
            log.warn("Lab 定义目录不存在: {}（跳过加载）", dir.getAbsolutePath());
            return;
        }
        File[] files = dir.listFiles((d, name) -> name.endsWith(".yml") || name.endsWith(".yaml"));
        if (files == null) {
            return;
        }
        ObjectMapper yaml = new ObjectMapper(new YAMLFactory());
        int loaded = 0;
        for (File f : files) {
            try {
                Map<String, Object> def = yaml.readValue(f, Map.class);
                String code = String.valueOf(def.get("code"));
                Lab lab = labMapper.selectOne(new LambdaQueryWrapper<Lab>().eq(Lab::getCode, code));
                boolean isNew = lab == null;
                if (isNew) {
                    lab = new Lab();
                    lab.setCode(code);
                }
                lab.setName((String) def.get("name"));
                lab.setTopicId(resolveTopicId((String) def.get("topic")));
                lab.setDifficulty(toInt(def.get("difficulty"), 1));
                lab.setScenario((String) def.get("scenario"));
                lab.setImage((String) def.getOrDefault("image", "devopshelper-base:latest"));
                lab.setSetupScript((String) def.get("setup"));
                lab.setCheckScript((String) def.get("check"));
                lab.setHints(toStringList(def.get("hints")));
                lab.setSolution((String) def.get("solution"));
                lab.setTimeLimitMinutes(toInt(def.get("timeLimitMinutes"), 60));
                lab.setTags(toStringList(def.get("tags")));
                lab.setSortOrder(toInt(def.get("sortOrder"), 99));
                if (isNew) {
                    labMapper.insert(lab);
                } else {
                    labMapper.updateById(lab);
                }
                loaded++;
            } catch (Exception e) {
                log.error("加载 Lab 定义失败: {}", f.getName(), e);
            }
        }
        log.info("已加载 {} 个 Lab 定义", loaded);
    }

    private Long resolveTopicId(String code) {
        if (code == null) {
            return null;
        }
        Topic t = topicMapper.selectOne(new LambdaQueryWrapper<Topic>().eq(Topic::getCode, code));
        return t != null ? t.getId() : null;
    }

    private int toInt(Object v, int def) {
        return v == null ? def : Integer.parseInt(String.valueOf(v));
    }

    @SuppressWarnings("unchecked")
    private List<String> toStringList(Object v) {
        if (v == null) {
            return null;
        }
        if (v instanceof List<?> list) {
            List<String> result = new ArrayList<>();
            list.forEach(i -> result.add(String.valueOf(i)));
            return result;
        }
        return List.of(String.valueOf(v));
    }

    /** 实验列表 + 当前运行实例 */
    public List<Map<String, Object>> listWithRuntime() {
        List<Map<String, Object>> result = new ArrayList<>();
        labMapper.selectList(new LambdaQueryWrapper<Lab>().orderByAsc(Lab::getSortOrder)).forEach(lab -> {
            Map<String, Object> item = new HashMap<>();
            item.put("lab", lab);
            LabInstance running = labInstanceMapper.selectOne(new LambdaQueryWrapper<LabInstance>()
                    .eq(LabInstance::getLabId, lab.getId())
                    .in(LabInstance::getStatus, LabInstance.STATUS_CREATED, LabInstance.STATUS_RUNNING)
                    .orderByDesc(LabInstance::getId).last("LIMIT 1"));
            item.put("activeInstance", running);
            item.put("completedCount", labInstanceMapper.selectCount(new LambdaQueryWrapper<LabInstance>()
                    .eq(LabInstance::getLabId, lab.getId())
                    .eq(LabInstance::getStatus, LabInstance.STATUS_COMPLETED)));
            result.add(item);
        });
        return result;
    }

    public Lab detail(Long id) {
        return labMapper.selectById(id);
    }

    /** 开始实验：销毁旧实例 → 创建容器 → 预埋故障脚本 */
    public LabInstance start(Long labId) {
        Lab lab = labMapper.selectById(labId);
        if (lab == null) {
            throw new IllegalArgumentException("实验不存在: " + labId);
        }
        if (!containerManager.imageExists()) {
            throw new IllegalStateException("基础镜像未构建，请先在实验室页面点击「构建基础镜像」");
        }
        // 单用户：同一实验只保留一个实例
        labInstanceMapper.selectList(new LambdaQueryWrapper<LabInstance>()
                        .eq(LabInstance::getLabId, labId)
                        .in(LabInstance::getStatus, LabInstance.STATUS_CREATED, LabInstance.STATUS_RUNNING))
                .forEach(this::destroyInstance);

        LabInstance instance = new LabInstance();
        instance.setLabId(labId);
        instance.setStatus(LabInstance.STATUS_CREATED);
        instance.setStartedAt(LocalDateTime.now());
        instance.setExpiredAt(LocalDateTime.now().plusMinutes(lab.getTimeLimitMinutes()));
        labInstanceMapper.insert(instance);

        String containerId = containerManager.createAndStart(
                "lab-" + lab.getCode() + "-" + instance.getId());
        instance.setContainerId(containerId);

        if (lab.getSetupScript() != null && !lab.getSetupScript().isBlank()) {
            try {
                containerManager.execScript(containerId, lab.getSetupScript(), 120);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new IllegalStateException("预埋脚本被中断");
            }
        }
        instance.setStatus(LabInstance.STATUS_RUNNING);
        labInstanceMapper.updateById(instance);
        return instance;
    }

    /** 判分：执行 check 脚本，解析 JSON 结果 */
    public Map<String, Object> check(Long instanceId) {
        LabInstance instance = labInstanceMapper.selectById(instanceId);
        if (instance == null || instance.getContainerId() == null) {
            throw new IllegalArgumentException("实例不存在: " + instanceId);
        }
        if (!LabInstance.STATUS_RUNNING.equals(instance.getStatus())) {
            throw new IllegalStateException("实例已结束，请重新开始实验");
        }
        Lab lab = labMapper.selectById(instance.getLabId());
        String output;
        try {
            output = containerManager.execScript(instance.getContainerId(), lab.getCheckScript(), 60);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new IllegalStateException("检测脚本被中断");
        }
        Map<String, Object> result = parseCheckOutput(output);
        instance.setCheckResult(result);
        boolean pass = Boolean.TRUE.equals(result.get("pass"));
        instance.setScore(pass ? 100 : (int) Math.round(
                (Double.parseDouble(String.valueOf(result.getOrDefault("score", pass ? 100 : 0))))));
        if (pass) {
            instance.setStatus(LabInstance.STATUS_COMPLETED);
            instance.setFinishedAt(LocalDateTime.now());
        }
        labInstanceMapper.updateById(instance);
        return result;
    }

    /** 解析 check 脚本输出：取最后一个 JSON 行 */
    @SuppressWarnings("unchecked")
    private Map<String, Object> parseCheckOutput(String output) {
        String[] lines = output.split("\n");
        for (int i = lines.length - 1; i >= 0; i--) {
            String line = lines[i].trim();
            if (line.startsWith("{")) {
                try {
                    return objectMapper.readValue(line, Map.class);
                } catch (Exception ignored) {
                }
            }
        }
        Map<String, Object> fallback = new HashMap<>();
        fallback.put("pass", false);
        fallback.put("message", "检测脚本未输出 JSON，原始输出:\n" + output);
        return fallback;
    }

    public LabInstance getInstance(Long instanceId) {
        return labInstanceMapper.selectById(instanceId);
    }

    public void destroyInstance(LabInstance instance) {
        if (instance.getContainerId() != null) {
            containerManager.destroy(instance.getContainerId());
        }
        if (LabInstance.STATUS_RUNNING.equals(instance.getStatus())
                || LabInstance.STATUS_CREATED.equals(instance.getStatus())) {
            instance.setStatus(LabInstance.STATUS_DESTROYED);
            instance.setFinishedAt(LocalDateTime.now());
            labInstanceMapper.updateById(instance);
        }
    }

    public void stop(Long instanceId) {
        LabInstance instance = labInstanceMapper.selectById(instanceId);
        if (instance == null) {
            throw new IllegalArgumentException("实例不存在");
        }
        destroyInstance(instance);
    }

    /** 每分钟清理过期实验容器 */
    @Scheduled(fixedDelay = 60_000)
    public void cleanupExpired() {
        labInstanceMapper.selectList(new LambdaQueryWrapper<LabInstance>()
                        .in(LabInstance::getStatus, LabInstance.STATUS_CREATED, LabInstance.STATUS_RUNNING)
                        .lt(LabInstance::getExpiredAt, LocalDateTime.now()))
                .forEach(instance -> {
                    destroyInstance(instance);
                    instance.setStatus(LabInstance.STATUS_EXPIRED);
                    labInstanceMapper.updateById(instance);
                    log.info("实验实例 {} 已过期销毁", instance.getId());
                });
    }

    public String buildBaseImage(String contextDir) {
        File dir = resolveDir(contextDir, "images/base");
        if (!new File(dir, "Dockerfile").exists()) {
            throw new IllegalArgumentException("Dockerfile 不存在: " + dir.getAbsolutePath());
        }
        return containerManager.buildBaseImage(dir);
    }
}
