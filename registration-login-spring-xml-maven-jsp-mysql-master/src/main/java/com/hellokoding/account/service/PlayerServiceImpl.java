package com.hellokoding.account.service;

import com.hellokoding.account.model.Player;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.repository.PlayerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Piotrek on 18-Nov-16.
 */
@Service
public class PlayerServiceImpl implements PlayerService {

    @Autowired
    private PlayerRepository playerRepository;

    @Override
    public void save(Player player,Team team) {
        System.out.println(" dont be afraid the fear 444 ");
        player.setTeam(team);
        playerRepository.save(player);
    }

    @Override
    public List<Player> findAllPlayers() {
        return playerRepository.findAll();
    }

    @Override
    public List<Player> findByTeam(Team team) {
        return playerRepository.findByTeam(team);
    }
}
