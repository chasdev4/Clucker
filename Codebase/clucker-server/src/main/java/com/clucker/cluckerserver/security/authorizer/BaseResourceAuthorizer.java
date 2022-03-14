package com.clucker.cluckerserver.security.authorizer;

import com.clucker.cluckerserver.api.user.repository.UserRepository;
import com.clucker.cluckerserver.exception.UnauthorizedException;
import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.model.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;

@Component
public abstract class BaseResourceAuthorizer<T> {

    @Autowired
    private UserRepository userRepository;

    protected SecurityContext getSecurityContext() {
        return SecurityContextHolder.getContext();
    }

    protected Authentication getAuthentication() {
        return getSecurityContext().getAuthentication();
    }

    protected String getUsername() {
        return getAuthentication().getName();
    }

    protected UserRole getRole() {
        GrantedAuthority grantedAuthority = new ArrayList<>(
                getAuthentication().getAuthorities())
                .get(0);
        return UserRole.valueOf(grantedAuthority.getAuthority());
    }

    protected User getUser() {
        return userRepository.findUserByUsername(getUsername())
                .orElseThrow(() -> new UnauthorizedException("User could not be found."));
    }

    protected boolean isAdmin() {
        return getRole().equals(UserRole.ROLE_ADMIN);
    }

    public abstract boolean canAccess(T returnObject);

}
