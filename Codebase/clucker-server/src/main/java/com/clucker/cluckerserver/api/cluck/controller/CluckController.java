package com.clucker.cluckerserver.api.cluck.controller;

import com.clucker.cluckerserver.api.cluck.service.CluckService;
import com.clucker.cluckerserver.api.cluck.service.CommentService;
import com.clucker.cluckerserver.dto.CluckResponse;
import com.clucker.cluckerserver.dto.CommentResponse;
import com.clucker.cluckerserver.dto.PostCluck;
import com.clucker.cluckerserver.dto.PostComment;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.Comment;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;

@RestController("cluck.controller")
@RequestMapping("/clucks")
@RequiredArgsConstructor
public class CluckController {

    private final CluckService cluckService;
    private final CommentService commentService;

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public CluckResponse getCluckById(@PathVariable String id) {
        return cluckService.mapToResponse(cluckService.getCluckById(id));
    }

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    public Page<CluckResponse> getClucks(Pageable pageable, @RequestParam(required = false) String search, Authentication authentication) {
        Page<Cluck> cluckPage = cluckService.getClucks(pageable, search);
        return cluckPage.map(cluckService::mapToResponse);
    }

    @PostMapping
    public ResponseEntity<CluckResponse> postCluck(@RequestBody @Valid PostCluck postCluck, Authentication authentication) {
        Cluck cluck = cluckService.postCluck(postCluck, authentication);
        CluckResponse response = cluckService.mapToResponse(cluck);

        URI uri = ServletUriComponentsBuilder.fromCurrentRequestUri()
                .path("/{id}")
                .buildAndExpand(response.getId())
                .toUri();

        return ResponseEntity
                .created(uri)
                .body(response);
    }

    @PostMapping("/{cluckId}/comments")
    public ResponseEntity<CommentResponse> postComment(@PathVariable String cluckId, @RequestBody @Valid PostComment postComment, Authentication authentication) {
        Comment comment = commentService.postComment(cluckId, postComment, authentication);
        CommentResponse response = commentService.mapToResponse(comment);

        URI uri = ServletUriComponentsBuilder.fromCurrentRequestUri()
                .path("/{id}")
                .buildAndExpand(comment.getId())
                .toUri();

        return ResponseEntity
                .created(uri)
                .body(response);

    }


    @GetMapping("/{cluckId}/comments")
    public Page<CommentResponse> getComments(@PathVariable String cluckId, Pageable pageable) {
        return commentService.getAllComments(cluckId, pageable).map(commentService::mapToResponse);
    }

    @PutMapping("/{cluckId}/rating")
    public CluckResponse addEggToCluck(@PathVariable String cluckId, Authentication authentication) {
        return cluckService.mapToResponse(
                cluckService.addEggToCluck(cluckId, authentication)
        );
    }

    @DeleteMapping("/{cluckId}/rating")
    public CluckResponse removeEggFromCluck(@PathVariable String cluckId, Authentication authentication) {
        return cluckService.mapToResponse(
                cluckService.removeEggFromCluck(cluckId, authentication)
        );
    }


}
