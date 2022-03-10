package com.clucker.cluckerserver.api.user.service;

import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
@RequiredArgsConstructor
@Slf4j
public class FollowerService {

    private final UserService userService;

    public void followUser(int id, Authentication authentication) {

        assertAuthenticated(authentication);

        String principal = authentication.getName();

        User user = userService.getUserByUsername(principal);
        User userToFollow = userService.getUserById(id);

        String username = userToFollow.getUsername();

        log.info("{} is attempting to follow {}", principal, username);

        if (userToFollow.getFollowers() == null)
            userToFollow.setFollowers(new ArrayList<>());

        if (user.getFollowing() == null)
            user.setFollowing(new ArrayList<>());

        userToFollow.getFollowers().add(user);
        user.getFollowing().add(userToFollow);

        userService.saveUser(user);
        userService.saveUser(userToFollow);

        log.info("{} successfully followed {}", principal, username);
    }

    public void unfollowUser(int id, Authentication authentication) {
        assertAuthenticated(authentication);

        String principal = authentication.getName();

        User user = userService.getUserByUsername(principal);
        User userToUnfollow = userService.getUserById(id);

        String username = userToUnfollow.getUsername();

        log.info("{} is attempting to unfollow {}", principal, username);

        userToUnfollow.getFollowers().remove(user);
        user.getFollowing().remove(userToUnfollow);

        userService.saveUser(user);
        userService.saveUser(userToUnfollow);

        log.info("{} successfully unfollowed {}", principal, username);
    }

    private void assertAuthenticated(Authentication authentication) {
        String principal = authentication.getName();

        if (StringUtils.isBlank(principal)) {
            throw new UnauthorizedException("User is unauthorized to perform this action.");
        }
    }

}
