package com.hellokoding.account.DTO;

/**
 * Created by Piotrek on 13-Dec-16.
 */
public class EmailDTO {

    private long id;
    private String subject;
    private String text;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
