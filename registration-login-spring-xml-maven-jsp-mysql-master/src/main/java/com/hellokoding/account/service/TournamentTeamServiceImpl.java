package com.hellokoding.account.service;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.TournamentTeam;
import com.hellokoding.account.repository.TournamentTeamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Piotrek on 28-Nov-16.
 */
@Service
public class TournamentTeamServiceImpl implements TournamentTeamService {

    @Autowired
    private TournamentTeamRepository tournamentTeamRepository;
    @Autowired
    private TournamentService tournamentService;

    @Override
    public void save(Team team, Tournament tournament) {

        int currentNumber = tournament.getCurrentNumberOfTeam();
        System.out.println("current : " + currentNumber);

        tournament.setCurrentNumberOfTeam(currentNumber++);
        tournamentService.updateTournament(currentNumber++,tournament.getId());
        TournamentTeam tournamentTeam = new TournamentTeam();
        tournamentTeam.setTeam(team);
        tournamentTeam.setTournament(tournament);
        tournamentTeamRepository.save(tournamentTeam);

    }

    @Override
    public List<TournamentTeam> findByTournament(Tournament tournament) {
        return tournamentTeamRepository.findByTournament(tournament);
    }


}
