package com.pk.server.master.mybaitsLock.exception;

public class UncachedMapperException extends Exception {

    private static final long serialVersionUID = -3239029321039349523L;

    public UncachedMapperException() {
        super();
    }

    public UncachedMapperException(String message) {
        super(message);
    }

    public UncachedMapperException(String message, Throwable cause) {
        super(message, cause);
    }

    public UncachedMapperException(Throwable cause) {
        super(cause);
    }

    protected UncachedMapperException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}