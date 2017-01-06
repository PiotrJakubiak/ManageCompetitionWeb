package com.hellokoding.account.service;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.TournamentTeam;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Piotrek on 28-Nov-16.
 */
public interface TournamentTeamService {
    @Transactional
    void save( Team team, Tournament tournament);
    List<TournamentTeam> findByTournament(Tournament tournament);
    List<TournamentTeam> findByTeam(Team team);

}
