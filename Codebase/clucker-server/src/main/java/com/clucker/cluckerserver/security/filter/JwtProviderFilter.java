package com.clucker.cluckerserver.security.filter;

import com.clucker.cluckerserver.dto.AuthenticationRequest;
import com.clucker.cluckerserver.exception.ForbiddenException;
import com.clucker.cluckerserver.security.util.JwtUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RequiredArgsConstructor
public class JwtProviderFilter extends UsernamePasswordAuthenticationFilter {

    private final JwtUtils jwtUtils;

    @Override
    @Autowired
    public void setAuthenticationManager(AuthenticationManager authenticationManager) {
        super.setAuthenticationManager(authenticationManager);
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        ObjectMapper mapper = new ObjectMapper();

        try {
            val authRequest = mapper.readValue(request.getInputStream(), AuthenticationRequest.class);
            val authentication = new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword());

            return getAuthenticationManager().authenticate(authentication);
        } catch (IOException e) {
            e.printStackTrace();
            throw new ForbiddenException("User could not be authenticated.");
        }
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authResult) throws IOException, ServletException {
        String token = "Bearer " + jwtUtils.generateJwt(authResult);
        response.setHeader(HttpHeaders.AUTHORIZATION, token);
    }
}
