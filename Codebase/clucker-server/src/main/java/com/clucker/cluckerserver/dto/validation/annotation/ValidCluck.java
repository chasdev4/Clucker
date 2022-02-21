package com.clucker.cluckerserver.dto.validation.annotation;

import com.clucker.cluckerserver.dto.validation.validator.CluckValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Documented
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = CluckValidator.class)
public @interface ValidCluck {
    String message() default "Cluck is not valid.";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
