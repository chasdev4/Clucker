package com.clucker.cluckerserver.api.cluck.service;

import com.clucker.cluckerserver.api.cluck.repository.CommentRepository;
import com.clucker.cluckerserver.api.user.service.UserService;
import com.clucker.cluckerserver.dto.CommentResponse;
import com.clucker.cluckerserver.dto.PostComment;
import com.clucker.cluckerserver.exception.CommentNotFoundException;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.Comment;
import com.clucker.cluckerserver.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class CommentService {

    private final CommentRepository commentRepository;
    private final CluckService cluckService;
    private final UserService userService;
    private final ModelMapper mapper;

    public Comment getCommentById(String id) {
        UUID uuid = UUID.fromString(id);
        return commentRepository.findById(uuid)
                .orElseThrow(CommentNotFoundException::new);
    }

    public Page<Comment> getCommentsByCluckId(String cluckId, Pageable pageable) {
        UUID uuid = UUID.fromString(cluckId);
        return commentRepository.findCommentsByCluckId(uuid, pageable);
    }

    public Comment postComment(String cluckId, @Valid PostComment postComment, Authentication authentication) {
        String username = authentication.getName();

        if (username == null)
            throw new UnauthorizedException("User is unauthorized to perform this action.");

        User user = userService.getUserByUsername(username);
        Cluck cluck = cluckService.getCluckById(cluckId);
        Comment comment = Comment.builder()
                .body(postComment.getBody())
                .cluck(cluck)
                .author(user)
                .build();
        return commentRepository.save(comment);
    }

    public Page<Comment> getAllComments(String cluckId, Pageable pageable) {
        UUID uuid = UUID.fromString(cluckId);
        return commentRepository.findCommentsByCluckId(uuid, pageable);
    }

    public CommentResponse mapToResponse(Comment comment) {
        CommentResponse response = mapper.map(comment, CommentResponse.class);
        response.setAuthor(comment.getAuthor().getUsername());
        response.setAuthorId(comment.getAuthor().getId());
        return response;
    }

}
