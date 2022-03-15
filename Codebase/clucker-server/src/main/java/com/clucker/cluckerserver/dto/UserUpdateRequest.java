package com.clucker.cluckerserver.dto;

import com.clucker.cluckerserver.dto.validation.annotation.ValidUsername;
import lombok.Builder;
import lombok.Data;

import javax.validation.constraints.Email;

@Data
@Builder
public class UserUpdateRequest {
    @ValidUsername
    private String username;
    @Email
    private String email;
    private String bio;
}
