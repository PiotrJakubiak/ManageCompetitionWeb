package com.hellokoding.account.service;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;

import java.util.Date;
import java.util.List;

/**
 * Created by Piotrek on 05-Dec-16.
 */
public interface GameService {
    void save(Game game);
    List<Game> findAllByTournament(Tournament tournament);
    Game findById(long id);
    List<Game> findNextGame(Tournament tournament);
    List<Game> findLastGames(Tournament tournament);
    List<Game> findAllByTeam(Tournament tournament,Team team);
    List<Game> findAllByTeam(Team team);

}
