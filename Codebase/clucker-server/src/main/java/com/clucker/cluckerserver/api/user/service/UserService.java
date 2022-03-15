package com.clucker.cluckerserver.api.user.service;

import com.clucker.cluckerserver.api.user.repository.UserRepository;
import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.dto.UserUpdateRequest;
import com.clucker.cluckerserver.exception.UserExistsException;
import com.clucker.cluckerserver.exception.UserNotFoundException;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.model.UserRole;
import com.clucker.cluckerserver.search.SimpleSearchSpecification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.validation.Valid;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

    private final UserRepository repository;
    private final PasswordEncoder encoder;
    private final ModelMapper mapper;

    public User getUserById(Integer id) {
        log.info("Attempting to find user with id: {}", id);
        return repository.findById(id)
                .orElseThrow(UserNotFoundException::new);
    }

    public User getUserByUsername(String username) {
        log.info("Attempting to find user with username: {}", username);
        return repository.findUserByUsername(username)
                .orElseThrow(UserNotFoundException::new);
    }

    public User getUserByEmail(String email) {
        log.info("Attempting to find user with email: {}", email);
        return repository.findUserByEmail(email)
                .orElseThrow(UserNotFoundException::new);
    }

    public boolean usernameAlreadyExists(String username) {
        return repository.findUserByUsername(username).isPresent();
    }

    public boolean emailAlreadyExists(String email) {
        return repository.findUserByEmail(email).isPresent();
    }

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

    public UserResponse mapToResponse(User user) {
        UserResponse userResponse = mapper.map(user, UserResponse.class);
        userResponse.setCluckCount(user.getClucks().size());
        userResponse.setFollowersCount(user.getFollowers().size());
        userResponse.setFollowingCount(user.getFollowing().size());
        int eggRating = user.getClucks().stream()
                .mapToInt(this::getCluckEggRating)
                .sum();
        userResponse.setEggRating(eggRating);
        return userResponse;
    }

    @PreAuthorize("@userResponseAuthorizer.canAccess(#id)")
    public void updateUser(int id, UserUpdateRequest updateRequest) {

        User user = getUserById(id);

        if (StringUtils.isNotBlank(updateRequest.getUsername()))
            user.setUsername(updateRequest.getUsername());

        if (StringUtils.isNotBlank(updateRequest.getEmail()))
            user.setEmail(updateRequest.getEmail());

        repository.save(user);

    }

    public void saveUser(User user) {
        repository.save(user);
    }

    public Page<User> getUsers(Pageable pageable, String search) {
        SimpleSearchSpecification<User> spec = new SimpleSearchSpecification<>(search);
        return repository.findAll(spec, pageable);
    }

    public boolean userExists(int id) {
        return repository.existsById(id);
    }

    private int getCluckEggRating(Cluck cluck) {
        int positiveEggs = cluck.getLikeUsers().size();
        int negativeEggs = cluck.getDislikeUsers().size();
        return positiveEggs - negativeEggs;
    }
}
