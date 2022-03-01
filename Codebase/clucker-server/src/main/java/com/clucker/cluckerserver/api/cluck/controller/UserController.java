package com.clucker.cluckerserver.api.cluck.controller;

import com.clucker.cluckerserver.api.cluck.service.CluckService;
import com.clucker.cluckerserver.dto.CluckResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("cluck.user.controller")
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

    private final CluckService cluckService;

    @GetMapping("/{id}/clucks")
    public Page<CluckResponse> getClucksByUserId(@PathVariable int id, Pageable pageable) {
        return cluckService.getClucksByAuthor(id, pageable).map(cluckService::mapToResponse);
    }

}
