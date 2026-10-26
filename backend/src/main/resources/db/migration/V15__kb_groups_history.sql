-- 知识库分组管理 + 文章修改历史
-- 1) topic 增加 builtin 标记：内置10大主题不可删除，用户自建分组可删
ALTER TABLE `topic` ADD COLUMN `builtin` TINYINT NOT NULL DEFAULT 0 COMMENT '1=内置知识点(不可删),0=用户自建分组';
UPDATE `topic` SET `builtin` = 1 WHERE `id` <= 10;

-- 2) 文章修改历史：每次修改前把旧版本快照入库，时间记录永不丢失
CREATE TABLE IF NOT EXISTS `kb_article_history` (
    `id`          BIGINT       NOT NULL AUTO_INCREMENT,
    `article_id`  BIGINT       NOT NULL,
    `title`       VARCHAR(200) NOT NULL,
    `content_md`  LONGTEXT,
    `saved_at`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '该版本被替换(存档)的时间',
    PRIMARY KEY (`id`),
    KEY `idx_article` (`article_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT '知识库文章历史版本';
