package com.clucker.cluckerserver.api.user.service;

import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.dto.UserUpdateRequest;
import com.clucker.cluckerserver.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.validation.Valid;

@Service
public interface UserService {

    User getUserById(Integer id);
    User getUserByUsername(String username);
    User getUserByEmail(String email);
    Page<User> getUsers(Pageable pageable, String search);
    boolean usernameAlreadyExists(String username);
    boolean emailAlreadyExists(String email);
    boolean userExists(int id);
    User createUser(@Valid UserRegistration registration);
    UserResponse mapToResponse(User user);
    void updateUser(int id, @Valid UserUpdateRequest updateRequest);
    void saveUser(User user);
}
