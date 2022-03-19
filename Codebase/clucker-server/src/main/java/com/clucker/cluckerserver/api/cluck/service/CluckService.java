package com.clucker.cluckerserver.api.cluck.service;

import com.clucker.cluckerserver.api.cluck.repository.CluckRepository;
import com.clucker.cluckerserver.api.user.service.UserService;
import com.clucker.cluckerserver.dto.CluckResponse;
import com.clucker.cluckerserver.dto.PostCluck;
import com.clucker.cluckerserver.exception.CluckNotFoundException;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.exception.UserNotFoundException;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.Comment;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.search.SimpleSearchSpecification;
import com.clucker.cluckerserver.security.service.SecurityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashSet;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class CluckService {

    private final CluckRepository cluckRepository;
    private final UserService userService;
    private final ModelMapper modelMapper;
    private final SecurityService securityService;

    @PreAuthorize("permitAll()")
    public Cluck getCluckById(String uuid) {
        UUID id = UUID.fromString(uuid);
        return cluckRepository.findById(id).orElseThrow(CluckNotFoundException::new);
    }

    @PreAuthorize("permitAll()")
    public Page<Cluck> getClucksByAuthor(int id, Pageable pageable) {
        if (!userService.userExists(id))
            throw new UserNotFoundException();

        return cluckRepository.getAllByAuthorId(id, pageable);
    }

    public Page<Cluck> getClucks(Pageable pageable, String search) {
        SimpleSearchSpecification<Cluck> spec = new SimpleSearchSpecification<>(search);
        return cluckRepository.findAll(spec, pageable);
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

    @Transactional
    @PreAuthorize("hasRole('CLUCKER')")
    public Cluck addEggToCluck(String cluckId, Authentication authentication) {
        Cluck cluck = getCluckById(cluckId);
        User user = userService.getUserByUsername(getUsername(authentication));

        if (cluck.getLikeUsers().remove(user) &&
                user.getLikedClucks().remove(cluck)) {
            userService.saveUser(user);
            return saveCluck(cluck);
        }

        if (cluck.getDislikeUsers() != null)
            cluck.getDislikeUsers().remove(user);

        if (cluck.getLikeUsers() == null)
            cluck.setLikeUsers(new HashSet<>());

        if (user.getDislikedClucks() != null)
            user.getDislikedClucks().remove(cluck);

        if (user.getLikedClucks() == null)
            user.setLikedClucks(new HashSet<>());

        cluck.getLikeUsers().add(user);
        user.getLikedClucks().add(cluck);
        userService.saveUser(user);
        return saveCluck(cluck);
    }

    @Transactional
    @PreAuthorize("hasRole('CLUCKER')")
    public Cluck removeEggFromCluck(String cluckId, Authentication authentication) {
        Cluck cluck = getCluckById(cluckId);
        User user = userService.getUserByUsername(getUsername(authentication));

        if (cluck.getDislikeUsers().remove(user) &&
                user.getDislikedClucks().remove(cluck)) {
            userService.saveUser(user);
            return saveCluck(cluck);
        }

        if (cluck.getLikeUsers() != null)
            cluck.getLikeUsers().remove(user);

        if (cluck.getDislikeUsers() == null)
            cluck.setDislikeUsers(new HashSet<>());

        if (user.getLikedClucks() != null)
            user.getLikedClucks().remove(cluck);

        if (user.getDislikedClucks() == null)
            user.setDislikedClucks(new HashSet<>());

        cluck.getDislikeUsers().add(user);
        user.getDislikedClucks().add(cluck);

        userService.saveUser(user);

        return saveCluck(cluck);
    }

    public CluckResponse mapToResponse(Cluck cluck) {
        CluckResponse response = modelMapper.map(cluck, CluckResponse.class);
        response.setId(cluck.getId().toString());
        response.setAuthor(cluck.getAuthor().getUsername());
        int eggRating = getCluckEggRating(cluck);
        response.setEggRating(eggRating);
        response.setCommentCount(cluck.getComments().size());

        if (securityService.userIsAuthenticated()) {
            User user = securityService.getUser();
            if (user.getLikedClucks().contains(cluck)) {
                response.setLiked(1);
            } else if (user.getDislikedClucks().contains(cluck)) {
                response.setLiked(-1);
            } else {
                response.setLiked(0);
            }
            boolean commented = user.getComments().stream()
                    .map(Comment::getCluck)
                    .distinct()
                    .collect(Collectors.toList())
                    .contains(cluck);
            response.setCommented(commented);
        }

        return response;
    }

    private int getCluckEggRating(Cluck cluck) {
        int positiveEggs = cluck.getLikeUsers().size();
        int negativeEggs = cluck.getDislikeUsers().size();
        return positiveEggs - negativeEggs;
    }

    public Cluck saveCluck(Cluck cluck) {
        return cluckRepository.save(cluck);
    }

    private String getUsername(Authentication authentication) {
        return Optional.of(authentication.getName()).orElseThrow(UserNotFoundException::new);
    }

}
