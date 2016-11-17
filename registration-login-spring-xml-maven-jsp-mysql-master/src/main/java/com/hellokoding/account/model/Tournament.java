package com.hellokoding.account.model;

import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;

/**
 * Created by Piotrek on 16-Nov-16.
 */
@Entity
@Transactional
@Table(name = "tournament")
public class Tournament {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private String name;
    private int maxNumberOfTeam;

    private String dateOfBegining;
    private String categoryOfTournament;
    private String stateOfTournament;
    private String typeTournament;


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


    public String getDateOfBegining() {
        return dateOfBegining;
    }

    public void setDateOfBegining(String dateOfBegining) {
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
}
