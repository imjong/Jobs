package com.project.jobs.domain;

public class NotUserException extends Exception {

	public NotUserException() {
		super("회원이 아닙니다.");
	}
	public NotUserException(String msg) {
		super(msg);
	}
}
