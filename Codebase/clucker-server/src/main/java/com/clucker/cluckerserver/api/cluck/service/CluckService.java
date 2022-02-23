package com.clucker.cluckerserver.api.cluck.service;

import com.clucker.cluckerserver.api.cluck.repository.CluckRepository;
import com.clucker.cluckerserver.dto.CluckResponse;
import com.clucker.cluckerserver.dto.PostCluck;
import com.clucker.cluckerserver.exception.CluckNotFoundException;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.exception.UserNotFoundException;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.api.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class CluckService {

    private final CluckRepository cluckRepository;
    private final UserService userService;
    private final ModelMapper modelMapper;

    @PreAuthorize("permitAll()")
    public Cluck getCluckById(String uuid) {
        UUID id = UUID.fromString(uuid);
        return cluckRepository.findById(id).orElseThrow(CluckNotFoundException::new);
    }

    public Page<Cluck> getClucksByAuthor(int id, Pageable pageable) {
        if (!userService.userExists(id))
            throw new UserNotFoundException();

        return cluckRepository.getAllByAuthorId(id, pageable);
    }

    @PreAuthorize("hasRole('CLUCKER')")
    public Cluck postCluck(PostCluck postCluck, Authentication authentication) {
        String username = authentication.getName();

        if (username == null)
            throw new UnauthorizedException("User is unauthorized to perform this action.");

        User user = userService.getUserByUsername(username);

        log.info("User '{}' requesting to post a new cluck.", user.getUsername());

        Cluck cluck = Cluck.builder()
                .body(postCluck.getBody())
                .author(user)
                .build();

        Cluck saved = cluckRepository.save(cluck);

        log.info("User '{}' posted a new cluck ({}).", user.getUsername(), saved.getId().toString());

        return saved;

    }

    public CluckResponse mapToResponse(Cluck cluck) {
        CluckResponse response = modelMapper.map(cluck, CluckResponse.class);
        response.setId(cluck.getId().toString());
        response.setAuthor(cluck.getAuthor().getUsername());
        return response;
    }

}
