package com.clucker.cluckerserver.controller;

import com.clucker.cluckerserver.annotation.IntegrationTest;
import com.clucker.cluckerserver.api.user.service.UserService;
import com.clucker.cluckerserver.dto.UserRegistration;
import com.clucker.cluckerserver.dto.UserUpdateRequest;
import com.clucker.cluckerserver.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import javax.transaction.Transactional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@IntegrationTest
@AutoConfigureMockMvc
@Transactional
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

        testRegisterUser(registration);

        User user = userService.getUserByUsername("testboy");

        assertNotNull(user);
        assertTrue(encoder.matches("TestP@ssword123", user.getPassword()));
    }

    @Test
    void test_checkAvailableUsername_returns_200_when_username_is_available() throws Exception {
        mockMvc.perform(get("/users/available-usernames")
                        .param("username", "available_username"))
                .andExpect(status().isOk());
    }

    @Test
    void test_checkAvailableUsername_returns_400_when_username_is_not_available() throws Exception {

        UserRegistration registration = UserRegistration.builder()
                .username("another_test_user")
                .password("TestP@ssword123")
                .email("testemail123@gmail.com")
                .build();

        testRegisterUser(registration);

        mockMvc.perform(get("/users/available-usernames")
                        .param("username", "another_test_user"))
                .andExpect(status().isBadRequest());
    }

    @Test
    @WithMockUser(username = "testboy", roles = {"ADMIN"})
    void test_updateUser_usernameIsChanged_when_userIsAdmin() throws Exception {

        UserRegistration registration = UserRegistration.builder()
                .username("toupdate")
                .password("TestP@ssword123")
                .email("testemail123@gmail.com")
                .build();

        testRegisterUser(registration);

        User user = userService.getUserByUsername("toupdate");

        assertNotNull(user);

        int id = user.getId();

        UserUpdateRequest request = UserUpdateRequest.builder()
                .username("newusername")
                .build();

        ObjectMapper mapper = new ObjectMapper();
        String body = mapper.writeValueAsString(request);

        mockMvc.perform(put("/users/{id}", id)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isOk());

        User user_after_update = userService.getUserById(id);
        assertEquals("newusername", user_after_update.getUsername());
    }

    @Test
    @WithMockUser(username = "toupdate", roles = {"CLUCKER"})
    void test_updateUser_usernameIsChanged_when_userIsClucker() throws Exception {

        UserRegistration registration = UserRegistration.builder()
                .username("toupdate")
                .password("TestP@ssword123")
                .email("testemail123@gmail.com")
                .build();

        testRegisterUser(registration);

        User user = userService.getUserByUsername("toupdate");

        assertNotNull(user);

        int id = user.getId();

        UserUpdateRequest request = UserUpdateRequest.builder()
                .username("newusername")
                .build();

        ObjectMapper mapper = new ObjectMapper();
        String body = mapper.writeValueAsString(request);

        mockMvc.perform(put("/users/{id}", id)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isOk());

        User user_after_update = userService.getUserById(id);
        assertEquals("newusername", user_after_update.getUsername());
    }

    @Test
    @WithMockUser(username = "someoneelse", roles = {"CLUCKER"})
    void test_updateUser_status_403_if_userIsNotAuthorized() throws Exception {
        UserRegistration registration = UserRegistration.builder()
                .username("toupdate")
                .password("TestP@ssword123")
                .email("testemail123@gmail.com")
                .build();

        UserRegistration registration2 = UserRegistration.builder()
                .username("someoneelse")
                .password("TestP@ssword123")
                .email("testemail1234@gmail.com")
                .build();

        testRegisterUser(registration);
        testRegisterUser(registration2);

        User user = userService.getUserByUsername("toupdate");

        assertNotNull(user);

        int id = user.getId();

        UserUpdateRequest request = UserUpdateRequest.builder()
                .username("newusername")
                .build();

        ObjectMapper mapper = new ObjectMapper();
        String body = mapper.writeValueAsString(request);

        mockMvc.perform(put("/users/{id}", id)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isForbidden());
    }

    private void testRegisterUser(UserRegistration registration) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        String body = mapper.writeValueAsString(registration);

        mockMvc.perform(post("/users")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isCreated());
    }

}
