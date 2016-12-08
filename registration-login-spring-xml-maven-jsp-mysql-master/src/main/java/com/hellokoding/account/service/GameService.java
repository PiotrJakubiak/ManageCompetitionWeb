package com.hellokoding.account.service;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Tournament;

import java.util.List;

/**
 * Created by Piotrek on 05-Dec-16.
 */
public interface GameService {
    void save(Game game);
    List<Game> findAllByTournament(Tournament tournament);
}
