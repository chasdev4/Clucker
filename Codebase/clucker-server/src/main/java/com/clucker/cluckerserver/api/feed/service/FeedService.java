package com.clucker.cluckerserver.api.feed.service;

import com.clucker.cluckerserver.api.cluck.repository.CluckRepository;
import com.clucker.cluckerserver.api.feed.specification.AuthorSpecification;
import com.clucker.cluckerserver.api.user.repository.UserRepository;
import com.clucker.cluckerserver.api.user.service.UserService;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class FeedService {

    private final UserService userService;
    private final UserRepository userRepository;
    private final CluckRepository cluckRepository;

    @PreAuthorize("hasRole('CLUCKER')")
    public Page<Cluck> getPersonalFeed(Authentication authentication, Pageable pageable) {

        String username = Optional.of(authentication.getName())
                .orElseThrow(() -> new UnauthorizedException("User is not authorized to perform this action."));

        User user = userService.getUserByUsername(username);
        List<User> authors = new ArrayList<>(user.getFollowing());
        authors.add(user);

        AuthorSpecification spec = new AuthorSpecification(authors);

        return cluckRepository.findAll(spec, pageable);

    }

    public Page<Cluck> getDiscoverFeed(Pageable pageable) {
        int minUserSize = (int) Math.min(userRepository.count(), 10L);
        List<User> topTenCluckersEggRating = getTopCluckersByEggRating(minUserSize);
        List<User> topTenCluckersFollowers = getTopCluckersByFollowers(minUserSize);
        List<User> topCluckers = new ArrayList<>(topTenCluckersEggRating);
        topCluckers.addAll(topTenCluckersFollowers);
        AuthorSpecification authorSpecification = new AuthorSpecification(topCluckers);

        return null;
    }

    private List<User> getTopCluckersByFollowers(int size) {
        return userRepository.findAll().stream()
                .sorted(Comparator.comparingInt(user -> user.getFollowers().size()))
                .limit(size).collect(Collectors.toList());
    }

    private List<User> getTopCluckersByEggRating(int size) {
        return userRepository.findAll().stream()
                .sorted(Comparator.comparingInt(User::getEggRating))
                .limit(size).collect(Collectors.toList());
    }

}
