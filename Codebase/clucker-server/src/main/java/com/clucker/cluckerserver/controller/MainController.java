package com.clucker.cluckerserver.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
@Slf4j
public class MainController {

    /**
     * Simple health check endpoint
     * Check @ http://localhost:8080/health
     * @return A string
     */
    @GetMapping("/health")
    @ResponseStatus(code = HttpStatus.OK)
    public String healthCheck() {
        log.info("Health check occurred.");
        return "Healthy!";
    }

}
