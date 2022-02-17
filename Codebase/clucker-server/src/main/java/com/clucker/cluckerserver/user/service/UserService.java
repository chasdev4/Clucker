package com.clucker.cluckerserver.user.service;

import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.dto.UserUpdateRequest;
import com.clucker.cluckerserver.model.User;
import org.springframework.stereotype.Service;

import javax.validation.Valid;

@Service
public interface UserService {

    User getUserById(Integer id);
    User getUserByUsername(String username);
    User getUserByEmail(String email);
    boolean usernameAlreadyExists(String username);
    boolean emailAlreadyExists(String email);
    User createUser(@Valid UserRegistration registration);
    UserResponse mapToResponse(User user);
    void updateUser(int id, @Valid UserUpdateRequest updateRequest);
}
