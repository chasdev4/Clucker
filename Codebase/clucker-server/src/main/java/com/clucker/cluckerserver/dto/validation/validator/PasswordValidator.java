package com.clucker.cluckerserver.dto.validation.validator;

import com.clucker.cluckerserver.dto.validation.annotation.ValidPassword;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class PasswordValidator implements ConstraintValidator<ValidPassword, String> {

    private static final String PASSWORD_REGEX = "^" +
            "(?=.*[0-9])" +         // At least one digit
            "(?=.*[a-z])" +         // At least one lowercase letter
            "(?=.*)" +         // At least one capital letter
            "(?=.*[@#$%^&+=_!])" +   // At least one symbol
            ".{8,}$";                // At least 8 characters in length

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return value == null || value.matches(PASSWORD_REGEX);
    }

}
