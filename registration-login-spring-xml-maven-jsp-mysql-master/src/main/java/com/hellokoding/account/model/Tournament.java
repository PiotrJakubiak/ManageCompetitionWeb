package com.hellokoding.account.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Created by Piotrek on 16-Nov-16.
 */
@Entity
@Transactional
@Table(name = "tournament")
public class Tournament {


    private long id;

    private String name;
    private int currentNumberOfTeam;
    private int maxNumberOfTeam;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateOfBegining;
    private String categoryOfTournament;

    private String stateOfTournament;
    private String typeTournament;

    private User user;
    private Set<TournamentTeam> tournamentTeams;
    private Set<Game> matches;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getMaxNumberOfTeam() {
        return maxNumberOfTeam;
    }

    public void setMaxNumberOfTeam(int maxNumberOfTeam) {
        this.maxNumberOfTeam = maxNumberOfTeam;
    }


    public Date getDateOfBegining() {
        return dateOfBegining;
    }

    public void setDateOfBegining(Date dateOfBegining) {
        this.dateOfBegining = dateOfBegining;
    }

    public String getCategoryOfTournament() {
        return categoryOfTournament;
    }

    public void setCategoryOfTournament(String categoryOfTournament) {
        this.categoryOfTournament = categoryOfTournament;
    }

    public String getTypeTournament() {
        return typeTournament;
    }

    public void setTypeTournament(String typeTournament) {
        this.typeTournament = typeTournament;
    }

    public String getStateOfTournament() {
        return stateOfTournament;
    }

    public void setStateOfTournament(String stateOfTournament) {
        this.stateOfTournament = stateOfTournament;
    }

    public int getCurrentNumberOfTeam() {
        return currentNumberOfTeam;
    }

    public void setCurrentNumberOfTeam(int currentNumberOfTeam) {
        this.currentNumberOfTeam = currentNumberOfTeam;
    }

    @OneToMany(mappedBy = "tournament",cascade = CascadeType.ALL)
    public Set<TournamentTeam> getTournamentTeams() {
        return tournamentTeams;
    }

    public void setTournamentTeams(Set<TournamentTeam> tournamentTeams) {
        this.tournamentTeams = tournamentTeams;
    }

    @OneToMany(mappedBy = "tournament")
    public Set<Game> getMatches() {
        return matches;
    }

    public void setMatches(Set<Game> matches) {
        this.matches = matches;
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
}
