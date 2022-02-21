package com.clucker.cluckerserver.cluck.service;

import com.clucker.cluckerserver.cluck.repository.CluckRepository;
import com.clucker.cluckerserver.dto.PostCluck;
import com.clucker.cluckerserver.exception.CluckNotFoundException;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.exception.UserNotFoundException;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CluckService {

    private final CluckRepository cluckRepository;
    private final UserService userService;

    public Cluck getCluckById(String uuid) {
        UUID id = UUID.fromString(uuid);
        return cluckRepository.findById(id).orElseThrow(CluckNotFoundException::new);
    }

    public Page<Cluck> getClucksByAuthor(String username, Pageable pageable) {
        if (!userService.usernameAlreadyExists(username))
            throw new UserNotFoundException();
        return cluckRepository.getAllByAuthorUsername(username, pageable);
    }

    public Cluck postCluck(PostCluck postCluck, Authentication authentication) {
        String username = authentication.getName();

        if (username == null)
            throw new UnauthorizedException("Unauthorized to perform this action.");

        User user = userService.getUserByUsername(username);

        Cluck cluck = Cluck.builder()
                .body(postCluck.getBody())
                .author(user)
                .build();

        return cluckRepository.save(cluck);

    }

}
