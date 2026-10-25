-- DevOpsHelper 初始表结构（单用户本地工具，预留 user_id 便于扩展）

-- 岗位
CREATE TABLE IF NOT EXISTS `position` (
    `id`          BIGINT       NOT NULL AUTO_INCREMENT,
    `code`        VARCHAR(50)  NOT NULL COMMENT '岗位编码',
    `name`        VARCHAR(100) NOT NULL COMMENT '岗位名称',
    `description` TEXT         COMMENT '岗位介绍',
    `skills`      JSON         COMMENT '技能路线图 [{stage, items[]}]',
    `sort_order`  INT          NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '岗位';

-- 知识点树
CREATE TABLE IF NOT EXISTS `topic` (
    `id`          BIGINT       NOT NULL AUTO_INCREMENT,
    `parent_id`   BIGINT       NULL COMMENT '父节点，NULL为顶层',
    `code`        VARCHAR(50)  NOT NULL,
    `name`        VARCHAR(100) NOT NULL,
    `description` VARCHAR(500) NULL,
    `icon`        VARCHAR(50)  NULL,
    `sort_order`  INT          NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '知识点';

-- 题目
CREATE TABLE IF NOT EXISTS `question` (
    `id`             BIGINT       NOT NULL AUTO_INCREMENT,
    `topic_id`       BIGINT       NOT NULL,
    `type`           VARCHAR(20)  NOT NULL COMMENT 'QA问答/SCENARIO场景/CHOICE选择',
    `difficulty`     TINYINT      NOT NULL DEFAULT 2 COMMENT '1初级 2中级 3高级',
    `title`          VARCHAR(500) NOT NULL COMMENT '题干',
    `content`        TEXT         COMMENT '补充背景（场景题场景描述）',
    `options`        JSON         COMMENT '选择题选项 ["A. xxx", ...]',
    `answer`         TEXT         COMMENT '参考答案（markdown）',
    `follow_ups`     JSON         COMMENT '追问列表',
    `tags`           JSON         COMMENT '标签',
    `frequency`      TINYINT      NOT NULL DEFAULT 3 COMMENT '面试出现频率 1-5',
    `position_codes` JSON         COMMENT '适用岗位编码',
    `source`         VARCHAR(100) COMMENT '来源：内置/自建/AI生成',
    `user_id`        BIGINT       NOT NULL DEFAULT 0 COMMENT '预留',
    `created_at`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_topic` (`topic_id`),
    KEY `idx_type` (`type`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '面试题';

-- SM-2 复习状态（每题一条最新状态）
CREATE TABLE IF NOT EXISTS `review_record` (
    `id`              BIGINT   NOT NULL AUTO_INCREMENT,
    `question_id`     BIGINT   NOT NULL,
    `quality`         TINYINT  NOT NULL COMMENT '最近一次评分 0-5',
    `ease_factor`     DOUBLE   NOT NULL DEFAULT 2.5,
    `interval_days`   INT      NOT NULL DEFAULT 0,
    `repeat_count`    INT      NOT NULL DEFAULT 0,
    `next_review_at`  DATETIME NOT NULL,
    `last_reviewed`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_question` (`question_id`),
    KEY `idx_next` (`next_review_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '复习状态';

-- 复习流水（统计曲线用）
CREATE TABLE IF NOT EXISTS `review_log` (
    `id`          BIGINT   NOT NULL AUTO_INCREMENT,
    `question_id` BIGINT   NOT NULL,
    `quality`     TINYINT  NOT NULL,
    `topic_id`    BIGINT   NOT NULL,
    `reviewed_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_time` (`reviewed_at`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '复习流水';

-- 知识库文章
CREATE TABLE IF NOT EXISTS `kb_article` (
    `id`           BIGINT       NOT NULL AUTO_INCREMENT,
    `topic_id`     BIGINT       NULL COMMENT '关联知识点',
    `title`        VARCHAR(200) NOT NULL,
    `content_md`   LONGTEXT,
    `question_ids` JSON         COMMENT '关联题目',
    `created_at`   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_topic` (`topic_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '知识库文章';

-- 个人笔记（按目标 upsert 单条）
CREATE TABLE IF NOT EXISTS `note` (
    `id`          BIGINT      NOT NULL AUTO_INCREMENT,
    `target_type` VARCHAR(20) NOT NULL COMMENT 'question/lab/topic',
    `target_id`   BIGINT      NOT NULL,
    `content`     TEXT,
    `created_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_target` (`target_type`, `target_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '个人笔记';

-- 实验定义
CREATE TABLE IF NOT EXISTS `lab` (
    `id`                 BIGINT       NOT NULL AUTO_INCREMENT,
    `code`               VARCHAR(50)  NOT NULL,
    `name`               VARCHAR(200) NOT NULL,
    `topic_id`           BIGINT       NULL,
    `difficulty`         TINYINT      NOT NULL DEFAULT 1,
    `scenario`           TEXT         COMMENT '场景描述',
    `image`              VARCHAR(200) NOT NULL DEFAULT 'devopshelper-base:latest',
    `setup_script`       TEXT         COMMENT '容器启动后预埋故障脚本',
    `check_script`       TEXT         COMMENT '检测判分脚本（输出JSON）',
    `hints`              JSON         COMMENT '分级提示',
    `solution`           TEXT         COMMENT '参考解法',
    `time_limit_minutes` INT          NOT NULL DEFAULT 60,
    `tags`               JSON,
    `sort_order`         INT          NOT NULL DEFAULT 0,
    `created_at`         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_code` (`code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '实操实验';

-- 实验容器实例
CREATE TABLE IF NOT EXISTS `lab_instance` (
    `id`           BIGINT      NOT NULL AUTO_INCREMENT,
    `lab_id`       BIGINT      NOT NULL,
    `container_id` VARCHAR(100) NULL COMMENT 'docker容器id',
    `status`       VARCHAR(20) NOT NULL COMMENT 'CREATED/RUNNING/EXPIRED/DESTROYED/COMPLETED',
    `score`        INT         NULL,
    `check_result` JSON        NULL COMMENT '判分明细',
    `started_at`   DATETIME    NULL,
    `expired_at`   DATETIME    NULL,
    `finished_at`  DATETIME    NULL,
    PRIMARY KEY (`id`),
    KEY `idx_lab` (`lab_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '实验实例';

-- AI 配置（单行表）
CREATE TABLE IF NOT EXISTS `ai_config` (
    `id`        BIGINT       NOT NULL DEFAULT 1,
    `base_url`  VARCHAR(200) NULL,
    `api_key`   VARCHAR(300) NULL,
    `model`     VARCHAR(100) NULL,
    `enabled`   TINYINT      NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT 'AI配置';

INSERT INTO `ai_config` (`id`, `enabled`) VALUES (1, 0);
