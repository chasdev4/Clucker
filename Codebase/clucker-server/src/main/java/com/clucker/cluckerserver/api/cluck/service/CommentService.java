package com.clucker.cluckerserver.api.cluck.service;

import com.clucker.cluckerserver.api.cluck.repository.CommentRepository;
import com.clucker.cluckerserver.exception.CommentNotFoundException;
import com.clucker.cluckerserver.model.Comment;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class CommentService {

    private CommentRepository commentRepository;

    public Comment getCommentById(String id) {
        UUID uuid = UUID.fromString(id);
        return commentRepository.findById(uuid)
                .orElseThrow(CommentNotFoundException::new);
    }

    public Page<Comment> getCommentsByCluckId(String cluckId, Pageable pageable) {
        UUID uuid = UUID.fromString(cluckId);
        return commentRepository.findCommentsByCluckId(uuid, pageable);
    }

}
