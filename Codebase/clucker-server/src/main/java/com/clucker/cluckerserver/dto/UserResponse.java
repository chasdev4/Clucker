package com.clucker.cluckerserver.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserResponse {
    private int id;
    private String username;
    private String email;
    private String role;
    private String bio;
    private double avatarHue;
    private String avatarImage;
    private int cluckCount;
    private int followingCount;
    private int followersCount;
    private int eggRating;
    private LocalDateTime joined;
    private LocalDateTime lastModified;
    private LocalDateTime lastLogin;
    private boolean currentlyFollowingUser;
}
