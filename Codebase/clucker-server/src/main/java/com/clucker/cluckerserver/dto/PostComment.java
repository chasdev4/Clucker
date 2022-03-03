package com.clucker.cluckerserver.dto;

import com.clucker.cluckerserver.dto.validation.annotation.ValidCluck;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class PostComment {
    @NotBlank
    @ValidCluck
    private String body;
}
