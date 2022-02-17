package com.clucker.cluckerserver.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserResponse {
    @JsonIgnore
    private int id;
    private String username;
    private String email;
    private String role;
    private LocalDateTime joined;
    private LocalDateTime lastModified;
    private LocalDateTime lastLogin;
}
