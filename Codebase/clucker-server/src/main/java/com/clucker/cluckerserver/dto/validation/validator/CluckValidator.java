package com.clucker.cluckerserver.dto.validation.validator;

import com.clucker.cluckerserver.dto.validation.annotation.ValidCluck;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class CluckValidator implements ConstraintValidator<ValidCluck, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return value == null || isValidCluck(value);
    }

    private boolean isValidCluck(String value) {
        return value.split("[\\s\\n\\r]").length <= 6 && value.length() <= 120;
    }
}
