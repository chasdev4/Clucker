package com.clucker.cluckerserver.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class MainController {

    /**
     * Simple health check endpoint
     * Check @ http://localhost:8080/health
     * @return A string
     */
    @GetMapping("/health")
    @ResponseStatus(code = HttpStatus.OK)
    public String healthCheck() {
        return "Healthy!";
    }

}
