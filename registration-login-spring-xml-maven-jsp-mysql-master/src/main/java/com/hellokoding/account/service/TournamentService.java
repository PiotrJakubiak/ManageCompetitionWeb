package com.hellokoding.account.service;

import com.hellokoding.account.model.Tournament;

import java.util.List;

/**
 * Created by Piotrek on 16-Nov-16.
 */
public interface TournamentService {
    void save(Tournament tournament);
    List<Tournament> findAllTournaments();
    Tournament getTournament(long tournamentId);
}
