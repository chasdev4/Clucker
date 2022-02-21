package com.clucker.cluckerserver.exception;

public class CluckNotFoundException extends NotFoundException {
    public CluckNotFoundException() {
        super("Cluck does not exist.");
    }
}
