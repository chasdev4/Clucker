package com.clucker.cluckerserver.controller;

import com.clucker.cluckerserver.annotation.IntegrationTest;
import com.clucker.cluckerserver.api.cluck.service.CluckService;
import com.clucker.cluckerserver.api.user.service.UserService;
import com.clucker.cluckerserver.dto.PostCluck;
import com.clucker.cluckerserver.dto.UserRegistration;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import javax.transaction.Transactional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@IntegrationTest
@AutoConfigureMockMvc
@Transactional
class CluckControllerTest {

    @Autowired
    MockMvc mockMvc;

    @Autowired
    ObjectMapper mapper;

    @Autowired
    UserService userService;

    @Autowired
    CluckService cluckService;

    @BeforeEach
    void setupUser() {
        UserRegistration registration = UserRegistration.builder()
                .username("testboy")
                .password("P@ssword123")
                .email("testemail@gmail.com")
                .build();

        userService.createUser(registration);
    }

    @Test
    @WithMockUser(username = "testboy", roles = {"CLUCKER"})
    void test_postCluck_returns_correct_response() throws Exception {

        String cluckBody = "This is a cluck body.";

        PostCluck postCluck = PostCluck.builder()
                .body(cluckBody)
                .build();

        String requestBody = mapper.writeValueAsString(postCluck);

        mockMvc.perform(post("/clucks")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(requestBody))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.body").value(cluckBody))
                .andExpect(jsonPath("$.author").value("testboy"));

    }

}
