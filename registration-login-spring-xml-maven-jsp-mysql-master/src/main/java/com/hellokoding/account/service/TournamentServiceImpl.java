package com.hellokoding.account.service;

import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.repository.TournamentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Piotrek on 16-Nov-16.
 */
@Service
public class TournamentServiceImpl implements TournamentService {

    @Autowired
    private TournamentRepository tournamentRepository;

    @Override
    public List<Tournament> findAllTournaments() {
        return tournamentRepository.findAll();
    }

    @Override
    public void save(Tournament tournament) {
        tournamentRepository.save(tournament);
    }

    @Override
    public Tournament getTournament(long tournamentId) {
        System.out.println("weszlo?");
        return tournamentRepository.findOne(tournamentId);
    }
}
