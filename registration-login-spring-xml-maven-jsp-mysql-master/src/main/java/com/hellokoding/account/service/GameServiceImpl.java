package com.hellokoding.account.service;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.repository.GameRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
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

    @Override
    public Game findById(long id) {
        return gameRepository.findOne(id);
    }

    @Override
    public List<Game> findNextGame(Tournament tournament) {

        return gameRepository.findNextGame(tournament, new PageRequest(0, tournament.getMaxNumberOfTeam()/2) {
        });
    }

    @Override
    public List<Game> findLastGames(Tournament tournament) {
        return gameRepository.findLastGames(tournament,new PageRequest(0,tournament.getMaxNumberOfTeam()/2));
    }

    @Override
    public List<Game> findAllByTeam(Tournament tournament,Team team) {
        return gameRepository.findAllByTeam(tournament,team);
    }

    @Override
    public List<Game> findAllByTeam(Team team) {
        return gameRepository.findAllByTeam(team);
    }
}
