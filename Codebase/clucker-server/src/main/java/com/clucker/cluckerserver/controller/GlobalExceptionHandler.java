package com.clucker.cluckerserver.controller;

import com.clucker.cluckerserver.dto.ValidationErrorResponse;
import com.clucker.cluckerserver.exception.ForbiddenException;
import com.clucker.cluckerserver.exception.HttpException;
import com.clucker.cluckerserver.exception.NotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.List;
import java.util.stream.Collectors;

@RestControllerAdvice
@Slf4j(topic = "Exception Handler")
public class GlobalExceptionHandler {

    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<String> handleNotFound(NotFoundException exception) {
        log.error(exception.getMessage());
        return ResponseEntity
                .status(exception.getStatus())
                .body(exception.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ValidationErrorResponse> handleValidationError(MethodArgumentNotValidException exception) {
        log.error(exception.getMessage());
        List<String> fieldErrors = exception.getFieldErrors().stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.toList());
        ValidationErrorResponse response = new ValidationErrorResponse();
        response.setErrors(fieldErrors);
        return ResponseEntity
                .badRequest()
                .body(response);
    }

    @ExceptionHandler({ ForbiddenException.class, AccessDeniedException.class})
    public ResponseEntity<String> handleForbiddenException(Exception exception) {
        log.error(exception.getMessage());
        return ResponseEntity
                .status(HttpStatus.FORBIDDEN)
                .body(exception.getMessage());
    }

    @ExceptionHandler(HttpException.class)
    public ResponseEntity<String> handleGeneralHttpException(HttpException exception) {
        log.error("HTTP Error: {}, Message: \"{}\"", exception.getStatus().value(), exception.getMessage());
        return ResponseEntity
                .status(exception.getStatus())
                .body(exception.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleAllExceptions(Exception exception) {
        log.error(exception.getMessage());
        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body("An error has occurred. Please contact your administrator.");
    }

}
