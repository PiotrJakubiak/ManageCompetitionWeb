package com.hellokoding.account.service;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.repository.GameRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Piotrek on 05-Dec-16.
 */
@Service
public class GameServiceImpl implements GameService {

    @Autowired
    private GameRepository gameRepository;

    @Override
    public void save(Game game) {
        gameRepository.save(game);
    }

    @Override
    public List<Game> findAllByTournament(Tournament tournament) {
        return gameRepository.findAllByTournament(tournament);
    }
}
