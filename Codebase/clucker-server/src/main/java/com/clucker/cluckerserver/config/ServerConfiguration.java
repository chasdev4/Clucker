package com.clucker.cluckerserver.config;

import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.nio.charset.StandardCharsets;
import java.security.Key;

@Configuration
@RequiredArgsConstructor
public class ServerConfiguration {

    private final AppProperties appProperties;

    @Bean
    public ModelMapper modelMapper() {
        ModelMapper mapper = new ModelMapper();
        mapper.getConfiguration().setAmbiguityIgnored(true)
                .setSkipNullEnabled(true);
        return mapper;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean(name = "jwtSecretKey")
    public Key jwtKey() {
        return Keys.hmacShaKeyFor(appProperties.getSecurity()
                .getJwtSecretKey().getBytes(StandardCharsets.UTF_8));
    }

}
