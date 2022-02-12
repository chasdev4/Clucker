package com.clucker.cluckerserver.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserResponse {
    private String username;
    private String email;
    private String role;
    private LocalDateTime joined;
    private LocalDateTime lastModified;
    private LocalDateTime lastLogin;
}
