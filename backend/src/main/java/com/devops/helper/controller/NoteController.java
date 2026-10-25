package com.devops.helper.controller;

import com.devops.helper.common.Result;
import com.devops.helper.entity.Note;
import com.devops.helper.service.NoteService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/notes")
@RequiredArgsConstructor
public class NoteController {

    private final NoteService noteService;

    @GetMapping
    public Result<Note> get(@RequestParam String targetType, @RequestParam Long targetId) {
        return Result.ok(noteService.get(targetType, targetId));
    }

    @PutMapping
    public Result<Note> upsert(@RequestBody NoteBody body) {
        return Result.ok(noteService.upsert(body.getTargetType(), body.getTargetId(), body.getContent()));
    }

    @Data
    public static class NoteBody {
        private String targetType;
        private Long targetId;
        private String content;
    }
}
