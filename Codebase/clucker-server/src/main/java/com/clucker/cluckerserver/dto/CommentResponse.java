package com.clucker.cluckerserver.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommentResponse {
    private String id;
    private String cluckId;
    private String body;
    private String author;
    private int authorId;
    private LocalDateTime posted;
    private LocalDateTime lastModified;
}
