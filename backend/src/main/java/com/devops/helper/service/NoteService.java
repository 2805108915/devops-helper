package com.devops.helper.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.devops.helper.entity.Note;
import com.devops.helper.mapper.NoteMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
@RequiredArgsConstructor
public class NoteService {

    private final NoteMapper noteMapper;

    public Note get(String targetType, Long targetId) {
        return noteMapper.selectOne(new LambdaQueryWrapper<Note>()
                .eq(Note::getTargetType, targetType).eq(Note::getTargetId, targetId));
    }

    /** 按目标 upsert 笔记（每个目标一条） */
    public Note upsert(String targetType, Long targetId, String content) {
        Note note = get(targetType, targetId);
        if (note == null) {
            note = new Note();
            note.setTargetType(targetType);
            note.setTargetId(targetId);
            note.setContent(content);
            noteMapper.insert(note);
        } else {
            note.setContent(StringUtils.hasText(content) ? content : "");
            noteMapper.updateById(note);
        }
        return note;
    }
}
