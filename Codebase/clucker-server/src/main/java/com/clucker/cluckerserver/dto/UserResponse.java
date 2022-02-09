package com.clucker.cluckerserver.dto;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class UserResponse {
    private String username;
    private String email;
    private LocalDate joined;
    private LocalDateTime lastLogin;
}
