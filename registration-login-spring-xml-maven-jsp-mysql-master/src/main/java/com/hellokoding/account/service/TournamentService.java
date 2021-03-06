package com.hellokoding.account.service;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.User;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by Piotrek on 16-Nov-16.
 */
public interface TournamentService {
    void save(Tournament tournament);
    void update(Tournament tournament);
    List<Tournament> findAllTournaments();
    Tournament findByName(String name);
    Tournament getTournament(long tournamentId);
    List<Tournament> findByUser(User user);

    void saveTeamToTournament(List<Team> team,Tournament tournament);

  void updateTournament(int currentNumberOfTeam,long id);
    void updateTournamentState(String stateOfTournament,long id);
    void setFixture(List<Team> teamList,Tournament tournament,int frequency,int numberOfRounds);
}
