package com.clucker.cluckerserver.exception;

public class UserExistsException extends BadRequestException {

    public UserExistsException(String userAttribute, String attributeValue) {
        super(String.format("User with the %s %s already exists.", userAttribute, attributeValue));
    }
}
