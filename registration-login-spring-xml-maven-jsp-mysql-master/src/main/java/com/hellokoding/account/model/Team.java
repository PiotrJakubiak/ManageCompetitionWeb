package com.hellokoding.account.model;

import javax.persistence.*;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

/**
 * Created by Piotrek on 15-Nov-16.
 */
@Entity
@Table(name = "team")
public class Team {

    private Long id;
    private String name;
    private String shortName;
    private String category;
    private String emailContact;
    private User user;
    private Set<Player> players;
    private Set<Game> matches;
    private Set<Game> matches2;
    private Set<TournamentTeam> tournamentTeams;


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

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getEmailContact() {
        return emailContact;
    }

    public void setEmailContact(String emailContact) {
        this.emailContact = emailContact;
    }

    @ManyToOne
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }
    public void setUser(User user)
    {
        this.user = user;
    }

    @OneToMany(mappedBy = "team")
    public Set<Player> getPlayers() {
        return players;
    }

    public void setPlayers(Set<Player> players) {
        this.players = players;
    }


    @OneToMany(mappedBy = "team",cascade = CascadeType.ALL)
    public Set<TournamentTeam> getTournamentTeams() {
        return tournamentTeams;
    }

    public void setTournamentTeams(Set<TournamentTeam> tournamentTeams) {
        this.tournamentTeams = tournamentTeams;
    }

    @OneToMany(mappedBy = "home",cascade = CascadeType.ALL)
    public Set<Game> getMatches() {
        return matches;
    }

    public void setMatches(Set<Game> matches) {
        this.matches = matches;
    }

    @OneToMany(mappedBy = "away")
    public Set<Game> getMatches2() {
        return matches2;
    }

    public void setMatches2(Set<Game> matches2) {
        this.matches2 = matches2;
    }

}
