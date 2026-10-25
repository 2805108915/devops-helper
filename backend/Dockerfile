# DevOpsHelper 后端镜像
FROM eclipse-temurin:17-jre

WORKDIR /app
COPY backend/target/devops-helper-0.1.0-SNAPSHOT.jar app.jar

# lab 定义目录（docker-compose 挂载 ./labs 到 /labs）
ENV LAB_DEFS_DIR=/labs/definitions \
    LAB_IMAGE_CONTEXT=/labs/images/base

EXPOSE 9800
ENTRYPOINT ["java", "-jar", "app.jar"]
