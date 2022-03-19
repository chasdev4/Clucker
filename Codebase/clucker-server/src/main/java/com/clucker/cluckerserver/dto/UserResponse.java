package com.clucker.cluckerserver.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;

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
    private OffsetDateTime joined;
    private OffsetDateTime lastModified;
    private OffsetDateTime lastLogin;
    private boolean currentlyFollowingUser;
}
