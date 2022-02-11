package com.clucker.cluckerserver.user.service;

import com.clucker.cluckerserver.annotation.IntegrationTest;
import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@IntegrationTest
@AutoConfigureMockMvc
class UserControllerTest {

    @Autowired
    MockMvc mockMvc;

    @Autowired
    UserService userService;

    @Autowired
    PasswordEncoder encoder;


    @Test
    void test_createUser_passwordIsHashed() throws Exception {

        UserRegistration registration = UserRegistration.builder()
                .username("testboy")
                .password("TestP@ssword123")
                .email("testemail@gmail.com")
                .build();

        ObjectMapper mapper = new ObjectMapper();
        String body = mapper.writeValueAsString(registration);

        mockMvc.perform(post("/users")
                .contentType(MediaType.APPLICATION_JSON)
                .content(body))
                .andExpect(status().isCreated());

        User user = userService.getUserByUsername("testboy");

        assertNotNull(user);
        assertTrue(encoder.matches("TestP@ssword123", user.getPassword()));
    }

}
