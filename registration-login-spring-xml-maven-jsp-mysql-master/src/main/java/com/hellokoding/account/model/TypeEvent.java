package com.hellokoding.account.model;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by Piotrek on 05-Dec-16.
 */
@Entity
@Table(name = "typeevent")
public class TypeEvent {

    private long id;
    private String name;
    private Set<Event> events;

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

    @OneToMany(mappedBy = "typeEvent")
    public Set<Event> getEvents() {
        return events;
    }

    public void setEvents(Set<Event> events) {
        this.events = events;
    }
}
