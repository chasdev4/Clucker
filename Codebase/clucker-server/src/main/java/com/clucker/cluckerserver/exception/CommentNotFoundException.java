package com.clucker.cluckerserver.exception;

public class CommentNotFoundException extends NotFoundException {
    public CommentNotFoundException() {
        super("Comment does not exist.");
    }
}
