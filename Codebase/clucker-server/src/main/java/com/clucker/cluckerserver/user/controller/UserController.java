package com.clucker.cluckerserver.user.controller;

import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/{id}")
    public UserResponse getUserById(@PathVariable int id) {
        return userService
                .mapToResponse(userService.getUserById(id));
    }

}
