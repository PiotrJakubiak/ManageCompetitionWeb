package com.hellokoding.account.model;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by Piotrek on 05-Dec-16.
 */
@Entity
@Table(name = "game")
public class Game {

    private long id;
    private int round;
    private Team home;
    private Team away;
    private Tournament tournament;

    @Temporal(TemporalType.TIMESTAMP)
    private Date date;

    private int goals_home;
    private int goals_away;
    private Set<Event> events;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getRound() {
        return round;
    }

    public void setRound(int round) {
        this.round = round;
    }

    @ManyToOne
    @JoinColumn(name = "home")
    public Team getHome() {
        return home;
    }

    public void setHome(Team home) {
        this.home = home;
    }
    @ManyToOne
    @JoinColumn(name = "away")
    public Team getAway() {
        return away;
    }

    public void setAway(Team away) {
        this.away = away;
    }
    @ManyToOne
    @JoinColumn(name = "tournament")
    public Tournament getTournament() {
        return tournament;
    }

    public void setTournament(Tournament tournament) {
        this.tournament = tournament;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getGoals_home() {
        return goals_home;
    }

    public void setGoals_home(int goals_home) {
        this.goals_home = goals_home;
    }

    public int getGoals_away() {
        return goals_away;
    }

    public void setGoals_away(int goals_away) {
        this.goals_away = goals_away;
    }

    @OneToMany(mappedBy = "game")
    public Set<Event> getEvents() {
        return events;
    }

    public void setEvents(Set<Event> events) {
        this.events = events;
    }
}
