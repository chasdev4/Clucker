package com.clucker.cluckerserver.dto.validation.annotation;

import com.clucker.cluckerserver.dto.validation.validator.PasswordValidator;
import com.clucker.cluckerserver.dto.validation.validator.UsernameValidator;

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
@Constraint(validatedBy = UsernameValidator.class)
public @interface ValidUsername {
    String message() default "Username is not valid.";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
