package com.hellokoding.account.repository;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.TournamentTeam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * Created by Piotrek on 28-Nov-16.
 */
public interface TournamentTeamRepository extends JpaRepository<TournamentTeam,Long> {
    List<TournamentTeam> findByTournament(Tournament tournament);

}
