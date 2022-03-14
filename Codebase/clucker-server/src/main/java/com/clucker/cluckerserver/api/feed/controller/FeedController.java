package com.clucker.cluckerserver.api.feed.controller;

import com.clucker.cluckerserver.api.cluck.service.CluckService;
import com.clucker.cluckerserver.api.feed.service.FeedService;
import com.clucker.cluckerserver.dto.CluckResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/feed")
@RequiredArgsConstructor
public class FeedController {

    private final CluckService cluckService;
    private final FeedService feedService;

    @GetMapping("/personal")
    public Page<CluckResponse> getPersonalFeed(Authentication authentication,
                                               @PageableDefault(
                                                       sort = {"posted"},
                                                       direction = Sort.Direction.ASC
                                               )
                                               Pageable pageable) {
        return feedService.getPersonalFeed(authentication, pageable).map(cluckService::mapToResponse);
    }

}
