package com.hellokoding.account.service;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.User;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Piotrek on 15-Nov-16.
 */
public interface TeamService {
    void save(Team team);
    List<Team> findAllTeams();
    List<Team> findByUser(User user);
    Team findById(long id);
    Team findByName(String name);
    List<Team> findByUserAndCategory(User user, String category);
   // int countByTournaments(long id);
    //List<Team> findTeamInTournament(Team team);
   @Transactional
    void update(Team team);

    List<Team> findAllByName(String name);
}
