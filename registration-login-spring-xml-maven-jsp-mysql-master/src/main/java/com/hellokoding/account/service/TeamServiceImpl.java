package com.hellokoding.account.service;

import com.hellokoding.account.model.Team;
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
        System.out.println(team.getName() + team.getId());
        teamRepository.save(team);

    }
    public List<Team> findAllTeams() {
        System.out.println("a takie gówno tu chcialem wysrac "+ teamRepository.findAll().size());
        List<Team> teams = teamRepository.findAll();
        return teamRepository.findAll();
    }

}
