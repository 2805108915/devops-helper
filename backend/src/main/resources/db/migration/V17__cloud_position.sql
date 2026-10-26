-- 云计算题目补岗位标签：生成器默认岗位不含 cloud，为知识点11的题目追加
UPDATE `question`
SET `position_codes` = JSON_ARRAY_APPEND(`position_codes`, '$', 'cloud')
WHERE `topic_id` = 11
  AND NOT JSON_CONTAINS(`position_codes`, '"cloud"');
