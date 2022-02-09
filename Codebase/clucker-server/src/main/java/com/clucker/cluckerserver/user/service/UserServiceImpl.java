package com.clucker.cluckerserver.user.service;

import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserResponse;
import com.clucker.cluckerserver.exception.UserNotFoundException;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.validation.Valid;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository repository;
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
    public User createUser(@Valid UserRegistration registration) {
        User user = mapper.map(registration, User.class);
        return repository.save(user);
    }

    @Override
    public UserResponse mapToResponse(User user) {
        UserResponse response = mapper.map(user, UserResponse.class);
        response.setJoined(LocalDate.now());
        response.setLastLogin(LocalDateTime.now());
        return response;
    }
}
