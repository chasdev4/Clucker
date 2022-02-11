package com.clucker.cluckerserver.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum UserRole {
    /**
     * Clucker role should only be able to view
     * and edit their own clucks.
     */
    ROLE_CLUCKER("CLUCKER"),
    /**
     * Administrator role has full access to
     * all the applications resources.
     */
    ROLE_ADMIN("ADMIN");

    private final String roleName;
}
