package com.clucker.cluckerserver.security.service;

import com.clucker.cluckerserver.api.user.repository.UserRepository;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class SecurityService {

    private final UserRepository userRepository;

    public Authentication getAuthentication() {
        return Optional.of(SecurityContextHolder.getContext().getAuthentication()).orElse(null);
    }

    public boolean userIsAuthenticated() {
        return getAuthentication() != null &&
                !(getAuthentication() instanceof AnonymousAuthenticationToken) &&
                getAuthentication().isAuthenticated();
    }

    public User getUser() {
        if (!userIsAuthenticated())
            throw new UnauthorizedException("User is not authorized to perform this action.");
        String username = getAuthentication().getName();
        log.info("Checking authentication of user '{}'...", username);
        return userRepository.findUserByUsername(username)
                .orElseThrow(() -> new UnauthorizedException("User is not authorized to perform this action."));
    }

}
