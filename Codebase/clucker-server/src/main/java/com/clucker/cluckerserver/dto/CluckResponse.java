package com.clucker.cluckerserver.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CluckResponse {

    private String id;
    private String body;
    private LocalDateTime posted;
    private LocalDateTime lastModified;
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

}
