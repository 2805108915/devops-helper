package com.devops.helper;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@MapperScan("com.devops.helper.mapper")
public class DevOpsHelperApplication {

    public static void main(String[] args) {
        SpringApplication.run(DevOpsHelperApplication.class, args);
    }
}
