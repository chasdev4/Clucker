package com.clucker.cluckerserver.api.user.service;

import com.clucker.cluckerserver.api.user.repository.UserRepository;
import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.dto.UserUpdateRequest;
import com.clucker.cluckerserver.exception.UserExistsException;
import com.clucker.cluckerserver.exception.UserNotFoundException;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.model.UserRole;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.modelmapper.ModelMapper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.validation.Valid;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {

    private final UserRepository repository;
    private final PasswordEncoder encoder;
    private final ModelMapper mapper;

    @Override
    public User getUserById(Integer id) {
        log.info("Attempting to find user with id: {}", id);
        return repository.findById(id)
                .orElseThrow(UserNotFoundException::new);
    }

    @Override
    public User getUserByUsername(String username) {
        log.info("Attempting to find user with username: {}", username);
        return repository.findUserByUsername(username)
                .orElseThrow(UserNotFoundException::new);
    }

    @Override
    public User getUserByEmail(String email) {
        log.info("Attempting to find user with email: {}", email);
        return repository.findUserByEmail(email)
                .orElseThrow(UserNotFoundException::new);
    }

    @Override
    public boolean usernameAlreadyExists(String username) {
        return repository.findUserByUsername(username).isPresent();
    }

    @Override
    public boolean emailAlreadyExists(String email) {
        return repository.findUserByEmail(email).isPresent();
    }

    @Override
    public User createUser(@Valid UserRegistration registration) {
        log.info("Attempting to register user: {}", registration.getUsername());

        if (usernameAlreadyExists(registration.getUsername()))
            throw new UserExistsException("username", registration.getUsername());

        if (emailAlreadyExists(registration.getEmail()))
            throw new UserExistsException("email", registration.getEmail());

        User user = mapper.map(registration, User.class);

        log.info("Hashing password...");
        String hashedPassword = encoder.encode(registration.getPassword());
        user.setPassword(hashedPassword);

        log.info("Setting user role to CLUCKER");
        user.setRole(UserRole.ROLE_CLUCKER);

        user.setEnabled(true); // Set to enabled for now

        return repository.save(user);
    }

    @Override
    public UserResponse mapToResponse(User user) {
        return mapper.map(user, UserResponse.class);
    }

    @PreAuthorize("@userResponseAuthorizer.canAccess(#id)")
    @Override
    public void updateUser(int id, UserUpdateRequest updateRequest) {

        User user = getUserById(id);

        if (StringUtils.isNotBlank(updateRequest.getUsername()))
            user.setUsername(updateRequest.getUsername());

        if (StringUtils.isNotBlank(updateRequest.getEmail()))
            user.setEmail(updateRequest.getEmail());

        repository.save(user);

    }

}
