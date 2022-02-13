package com.clucker.cluckerserver.dto.validation.validator;

import com.clucker.cluckerserver.dto.validation.annotation.ValidUsername;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UsernameValidator implements ConstraintValidator<ValidUsername, String> {

    private final static String USERNAME_REGEX = "^[A-Za-z0-9_]+$";

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return value == null || value.matches(USERNAME_REGEX);
    }
}
