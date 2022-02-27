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
    private String author;

}
