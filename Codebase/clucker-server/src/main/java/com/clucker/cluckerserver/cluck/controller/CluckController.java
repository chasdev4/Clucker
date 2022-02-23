package com.clucker.cluckerserver.cluck.controller;

import com.clucker.cluckerserver.cluck.service.CluckService;
import com.clucker.cluckerserver.dto.CluckResponse;
import com.clucker.cluckerserver.dto.PostCluck;
import com.clucker.cluckerserver.model.Cluck;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping("/clucks")
@RequiredArgsConstructor
public class CluckController {

    private final CluckService cluckService;

    @GetMapping("/{id}")
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public CluckResponse getCluckById(@PathVariable String id) {
        return cluckService.mapToResponse(cluckService.getCluckById(id));
    }

    @PostMapping
    @ResponseStatus(HttpStatus.OK)
    public CluckResponse postCluck(@RequestBody @Valid PostCluck postCluck, Authentication authentication) {
        return cluckService.mapToResponse(cluckService.postCluck(postCluck, authentication));
    }



}
