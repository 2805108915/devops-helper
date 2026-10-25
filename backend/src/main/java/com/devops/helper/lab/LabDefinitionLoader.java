package com.devops.helper.lab;

import com.devops.helper.service.LabService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

/**
 * 应用启动后加载 labs/definitions/*.yml
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class LabDefinitionLoader implements ApplicationRunner {

    private final LabService labService;

    @Override
    public void run(ApplicationArguments args) {
        try {
            labService.loadDefinitions();
        } catch (Exception e) {
            log.error("Lab 定义加载失败（不影响其他功能）", e);
        }
    }
}
