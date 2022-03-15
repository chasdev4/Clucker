package com.clucker.cluckerserver.security.service;

import com.clucker.cluckerserver.api.user.repository.UserRepository;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.model.UserDetailsImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findUserByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException(String.format("User not found with username %s.", username)));
        return UserDetailsImpl.fromUser(user);
    }
}
