package com.hellokoding.account.model;


import javax.persistence.*;

/**
 * Created by Piotrek on 28-Nov-16.
 */
@Entity
@Table(name = "tournament_team")
public class TournamentTeam {

    private Long id;
    private Team team;
    private Tournament tournament;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @ManyToOne
    @JoinColumn(name = "team_id")
    public Team getTeam(){
        return team;
    }

    public void setTeam(Team team) {
        this.team = team;
    }

    @ManyToOne
    @JoinColumn(name = "tournament_id")
    public Tournament getTournament(){
        return tournament;
    }
    public void setTournament(Tournament tournament){
        this.tournament = tournament;
    }


}
