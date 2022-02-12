package com.clucker.cluckerserver.security.util;

import com.clucker.cluckerserver.annotation.IntegrationTest;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.model.UserDetailsImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.TestingAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@IntegrationTest
class JwtUtilTest {

    @Autowired
    JwtUtil jwtUtil;
    UserDetailsImpl userDetails;
    Authentication authentication;

    @BeforeEach
    void setUp() {
        userDetails = UserDetailsImpl.builder()
                .username("testboy")
                .build();
        authentication = new TestingAuthenticationToken(userDetails, null);
    }

    @Test
    void test_generateJwt() {
        String token = jwtUtil.generateJwt(authentication);
        assertNotNull(token);
    }

    @Test
    void test_getUsernameFromToken() {
        String token = jwtUtil.generateJwt(authentication);
        String username = jwtUtil.getUsernameFromToken(token);
        assertEquals("testboy", username);
    }

}
