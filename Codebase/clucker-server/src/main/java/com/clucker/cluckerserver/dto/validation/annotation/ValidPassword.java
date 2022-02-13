package com.clucker.cluckerserver.dto.validation.annotation;

import com.clucker.cluckerserver.dto.validation.validator.PasswordValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Validate that a password includes at least a
 * lowercase letter, uppercase letter, a number,
 * and a special character. The password must also
 * be at least 8 characters long.
 */
@Documented
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = PasswordValidator.class)
public @interface ValidPassword {
    String message() default "Password is not valid.";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
