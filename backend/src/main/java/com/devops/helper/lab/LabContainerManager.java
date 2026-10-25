package com.devops.helper.lab;

import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.command.CreateContainerResponse;
import com.github.dockerjava.api.command.ExecCreateCmdResponse;
import com.github.dockerjava.api.exception.NotFoundException;
import com.github.dockerjava.api.model.HostConfig;
import com.github.dockerjava.core.command.ExecStartResultCallback;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Lab 沙箱容器管理：创建（交互式 bash 终端）/ 预埋故障 / 判分 / 销毁
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class LabContainerManager {

    private final DockerClient dockerClient;

    @Value("${lab.base-image}")
    private String baseImage;

    @Value("${lab.memory-mb}")
    private long memoryMb;

    @Value("${lab.cpu-period}")
    private long cpuPeriod;

    @Value("${lab.cpu-quota}")
    private long cpuQuota;

    /** 基础镜像是否已构建 */
    public boolean imageExists() {
        try {
            dockerClient.inspectImageCmd(baseImage).exec();
            return true;
        } catch (NotFoundException e) {
            return false;
        }
    }

    /** 构建基础镜像（阻塞，返回镜像 id） */
    public String buildBaseImage(File contextDir) {
        return dockerClient.buildImageCmd()
                .withBaseDirectory(contextDir)
                .withDockerfile(new File(contextDir, "Dockerfile"))
                .withTags(Set.of(baseImage))
                .start().awaitImageId();
    }

    /**
     * 创建并启动实验容器。
     * PID1 = 交互式 bash（tty + stdin open），Web 终端直接 attach 到它。
     */
    public String createAndStart(String containerName) {
        HostConfig hostConfig = HostConfig.newHostConfig()
                .withMemory(memoryMb * 1024 * 1024)
                .withMemorySwap(memoryMb * 1024 * 1024) // 禁止超发 swap
                .withCpuPeriod(cpuPeriod)
                .withCpuQuota(cpuQuota)
                .withNetworkMode("bridge");

        CreateContainerResponse resp = dockerClient.createContainerCmd(baseImage)
                .withName(containerName)
                .withCmd("bash")
                .withTty(true)
                .withStdinOpen(true)
                .withEnv("TERM=xterm-256color", "COLUMNS=120", "LINES=40",
                        "LANG=C.UTF-8", "DEBIAN_FRONTEND=noninteractive")
                .withHostConfig(hostConfig)
                .exec();
        dockerClient.startContainerCmd(resp.getId()).exec();
        return resp.getId();
    }

    /** 容器内执行脚本并返回 stdout（判分与预埋共用） */
    public String execScript(String containerId, String script, long timeoutSeconds) throws InterruptedException {
        ExecCreateCmdResponse exec = dockerClient.execCreateCmd(containerId)
                .withCmd("sh", "-c", script)
                .withAttachStdout(true)
                .withAttachStderr(true)
                .exec();
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ByteArrayOutputStream err = new ByteArrayOutputStream();
        boolean finished = dockerClient.execStartCmd(exec.getId())
                .exec(new ExecStartResultCallback(out, err))
                .awaitCompletion(timeoutSeconds, TimeUnit.SECONDS);
        if (!finished) {
            throw new IllegalStateException("脚本执行超时（" + timeoutSeconds + "s），请检查是否死循环");
        }
        return out.toString(java.nio.charset.StandardCharsets.UTF_8);
    }

    /** 容器是否还在运行 */
    public boolean isRunning(String containerId) {
        try {
            return Boolean.TRUE.equals(dockerClient.inspectContainerCmd(containerId).exec()
                    .getState().getRunning());
        } catch (NotFoundException e) {
            return false;
        }
    }

    public void destroy(String containerId) {
        try {
            dockerClient.removeContainerCmd(containerId).withForce(true).exec();
        } catch (NotFoundException e) {
            log.debug("容器已不存在: {}", containerId);
        }
    }

    public String dockerVersion() {
        return dockerClient.versionCmd().exec().getVersion();
    }
}
