package com.hellokoding.account.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

/**
 * Created by Piotrek on 04-Dec-16.
 */
@Service
public class EmailAPI {


    @Autowired
    private MailSender crunchifymail; // MailSender interface defines a strategy
    // for sending simple mails

    public void crunchifyReadyToSendEmail(String toAddress, String fromAddress, String subject, String msgBody) {

        System.out.println("wysylam");
        SimpleMailMessage crunchifyMsg = new SimpleMailMessage();
        crunchifyMsg.setFrom(fromAddress);
        crunchifyMsg.setTo(toAddress);
        crunchifyMsg.setSubject(subject);
        crunchifyMsg.setText(msgBody);
        crunchifymail.send(crunchifyMsg);
    }
}

