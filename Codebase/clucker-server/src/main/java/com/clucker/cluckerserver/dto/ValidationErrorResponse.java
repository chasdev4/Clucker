package com.clucker.cluckerserver.dto;

import lombok.Data;

import java.util.List;

@Data
public class ValidationErrorResponse {
    private List<String> errors;
}
