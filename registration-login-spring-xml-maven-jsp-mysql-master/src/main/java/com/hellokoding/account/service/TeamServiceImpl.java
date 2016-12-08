package com.hellokoding.account.service;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.User;
import com.hellokoding.account.repository.TeamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Piotrek on 15-Nov-16.
 */
@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    private TeamRepository teamRepository;

    @Override
    public void save(Team team) {
        teamRepository.save(team);

    }
    public List<Team> findAllTeams() {
        return teamRepository.findAll();
    }

    @Override
    public Team findById(long id) {
        return teamRepository.findById(id);
    }

    @Override
    public List<Team> findByUser(User user) {
        return teamRepository.findByUser(user);
    }

    @Override
    public Team findByName(String name) {
        return teamRepository.findByName(name);
    }
/*
    @Override
    public int countByTournaments(long id) {
        return teamRepository.countByTournaments_id(id);
    }

    @Override
    public List<Team> findTeamInTournament(long id) {
        return teamRepository.findByTournaments_id(id);
    }
    */

    @Override
    public void update(Team team) {
        teamRepository.save(team);
    }

    @Override
    public List<Team> findByUserAndCategory(User user, String category) {
        return teamRepository.findByUserAndCategory(user,category);
    }

    @Override
    public List<Team> findAllByName(String name) {
        return teamRepository.findAllByName(name);
    }
}
