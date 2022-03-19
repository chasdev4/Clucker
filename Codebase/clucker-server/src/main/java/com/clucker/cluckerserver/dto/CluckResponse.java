package com.clucker.cluckerserver.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CluckResponse {

    private String id;
    private String body;
    private OffsetDateTime posted;
    private OffsetDateTime lastModified;
    private int authorId;
    private String author;
    private int eggRating;
    private int commentCount;
    /**
     * -1 - Disliked
     *  0 - N/A
     *  1 - Liked
     */
    private int liked;
    private boolean commented;

}
