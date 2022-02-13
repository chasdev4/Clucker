package com.clucker.cluckerserver.user.controller;

import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserService userService;

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public UserResponse getUserById(@PathVariable int id) {
        return userService
                .mapToResponse(userService.getUserById(id));
    }

    @GetMapping("/available-usernames")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<String> checkAvailableUsername(@RequestParam String username) {
        log.info("Checking if username {} is available.", username);
        boolean usernameExists = userService.usernameAlreadyExists(username);
        HttpStatus status =  usernameExists ? HttpStatus.BAD_REQUEST : HttpStatus.OK;
        String messageFormat = usernameExists ? "Username %s already exists." : "Username %s is available!";
        String message = String.format(messageFormat, username);
        log.info(message);
        return ResponseEntity
                .status(status)
                .body(message);
    }


    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<UserResponse> createUser(@RequestBody @Valid UserRegistration registration) {

        User user = userService.createUser(registration);

        log.info("Successfully registered {}!", user.getUsername());

        URI uri = ServletUriComponentsBuilder
                .fromCurrentRequestUri()
                .path("/{id}")
                .buildAndExpand(user.getId())
                .toUri();

        log.info("User resource location: {}", uri);

        return ResponseEntity.created(uri)
                .body(userService.mapToResponse(user));

    }

}
