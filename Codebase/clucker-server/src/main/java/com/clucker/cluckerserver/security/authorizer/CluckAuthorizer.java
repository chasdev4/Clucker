package com.clucker.cluckerserver.security.authorizer;

import com.clucker.cluckerserver.model.Cluck;

public class CluckAuthorizer extends BaseResourceAuthorizer<Cluck> {
    @Override
    public boolean canAccess(Cluck returnObject) {
        return false;
    }
}
