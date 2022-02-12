package com.clucker.cluckerserver.security.filter;

import com.clucker.cluckerserver.dto.AuthenticationRequest;
import com.clucker.cluckerserver.exception.ForbiddenException;
import com.clucker.cluckerserver.model.UserDetailsImpl;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Jwts;
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
import java.security.Key;
import java.util.Date;

@RequiredArgsConstructor
public class JwtProviderFilter extends UsernamePasswordAuthenticationFilter {

    private final Key jwtKey;

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
        UserDetailsImpl userPrincipal = (UserDetailsImpl) authResult.getPrincipal();
        String token = "Bearer " + Jwts.builder()
                .setSubject(userPrincipal.getUsername())
                .setIssuedAt(new Date())
                .signWith(jwtKey)
                .compact();;
        response.setHeader(HttpHeaders.AUTHORIZATION, token);
    }
}
