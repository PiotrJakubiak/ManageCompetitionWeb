package com.hellokoding.account.DTO;

import com.hellokoding.account.model.Team;

public class TournamentTeamDTO {

    private String team;
    private String tournament;

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public String getTournament() {
        return tournament;
    }

    public void setTournament(String tournament) {
        this.tournament = tournament;
    }
}
