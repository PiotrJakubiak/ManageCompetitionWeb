package com.hellokoding.account.service;

import com.hellokoding.account.model.Team;

import java.util.List;

/**
 * Created by Piotrek on 15-Nov-16.
 */
public interface TeamService {
    void save(Team team);
    List<Team> findAllTeams();
}
