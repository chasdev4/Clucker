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
    ROLE_CLUCKER("ROLE_CLUCKER"),
    /**
     * Administrator role has full access to
     * all the applications resources.
     */
    ROLE_ADMIN("ROLE_ADMIN");

    private final String roleName;
}
