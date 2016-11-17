package com.hellokoding.account.model;

import javax.persistence.*;

/**
 * Created by Piotrek on 15-Nov-16.
 */
@Entity
@Table(name = "player")
public class Player {

    private Long id;
    private String name;
    private String position;
    private String number;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }
}
