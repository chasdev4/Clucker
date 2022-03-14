package com.clucker.cluckerserver.api.feed.service;

import com.clucker.cluckerserver.api.cluck.repository.CluckRepository;
import com.clucker.cluckerserver.api.user.service.UserService;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
public class FeedService {

    private final UserService userService;
    private final CluckRepository cluckRepository;

    @PreAuthorize("hasRole('CLUCKER')")
    public Page<Cluck> getPersonalFeed(Authentication authentication, Pageable pageable) {

        String username = Optional.of(authentication.getName())
                .orElseThrow(() -> new UnauthorizedException("User is not authorized to perform this action."));

        User user = userService.getUserByUsername(username);
        List<User> following = new ArrayList<>(user.getFollowing());
        following.add(user);

        return cluckRepository.getClucksByAuthorIn(following, pageable);
    }

}
