package com.clucker.cluckerserver.dto;

import com.clucker.cluckerserver.dto.validation.annotation.ValidCluck;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PostComment {
    @NotBlank
    @ValidCluck
    private String body;
}
