package com.hellokoding.account.service;

import com.hellokoding.account.model.Player;
import com.hellokoding.account.model.Team;

import java.util.List;

/**
 * Created by Piotrek on 18-Nov-16.
 */
public interface PlayerService {
    void save(Player player,Team team);
    List<Player> findAllPlayers();
    List<Player> findByTeam(Team team);
}
