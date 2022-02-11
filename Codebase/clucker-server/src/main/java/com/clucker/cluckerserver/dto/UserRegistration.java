package com.clucker.cluckerserver.dto;

import com.clucker.cluckerserver.dto.validation.annotation.ValidPassword;
import com.clucker.cluckerserver.dto.validation.annotation.ValidUsername;
import lombok.Builder;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

/**
 * DTO that is used to create a user.
 */
@Data
@Builder
public class UserRegistration {

    @NotBlank
    @ValidUsername
    private String username;

    @NotBlank
    @ValidPassword
    private String password;

    @Email
    @NotBlank
    private String email;

}
