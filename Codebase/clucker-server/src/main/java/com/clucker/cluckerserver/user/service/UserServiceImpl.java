package com.clucker.cluckerserver.user.service;

import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.exception.UserExistsException;
import com.clucker.cluckerserver.exception.UserNotFoundException;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.model.UserRole;
import com.clucker.cluckerserver.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
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
        return repository.findById(id)
                .orElseThrow(UserNotFoundException::new);
    }

    @Override
    public User getUserByUsername(String username) {
        return repository.findUserByUsername(username)
                .orElseThrow(UserNotFoundException::new);
    }

    @Override
    public User getUserByEmail(String email) {
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

}
