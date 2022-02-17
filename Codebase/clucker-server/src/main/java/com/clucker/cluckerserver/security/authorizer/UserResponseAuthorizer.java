package com.clucker.cluckerserver.security.authorizer;

import com.clucker.cluckerserver.dto.UserResponse;
import org.springframework.stereotype.Component;

@Component("userResponseAuthorizer")
public class UserResponseAuthorizer extends BaseResourceAuthorizer<UserResponse> {

    @Override
    public boolean canAccess(UserResponse returnObject) {
        return isAdmin() || getUser().getId() == returnObject.getId();
    }

    public boolean canAccess(int userId) {
        return isAdmin() || getUser().getId() == userId;
    }

}
