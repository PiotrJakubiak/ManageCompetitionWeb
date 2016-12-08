package com.hellokoding.account.service;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.repository.GameRepository;
import com.hellokoding.account.repository.TeamRepository;
import com.hellokoding.account.repository.TournamentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by Piotrek on 16-Nov-16.
 */
@Service
public class TournamentServiceImpl implements TournamentService {

    @Autowired
    private TournamentRepository tournamentRepository;

    @Autowired
    private TeamRepository teamRepository;

    @Autowired
    private GameRepository gameRepository;

    @Override
    public List<Tournament> findAllTournaments() {
        return tournamentRepository.findAll();
    }

    @Override
    public void save(Tournament tournament) {

       // List<Tournament> list = findByName();
        //List<Team> list2=teamRepository.findByUser(userService.findByUsername(securityService.findLoggedInUsername()));
        //System.out.println(list2.size());
        //tournament.setTeams(new LinkedList<>((teamRepository.findByTeam())));
       // System.out.println();
        tournamentRepository.save(tournament);
    }

    @Override
    public Tournament getTournament(long tournamentId) {
        System.out.println("weszlo?");
        return tournamentRepository.findOne(tournamentId);
    }

    @Override
    public List<Tournament> findByName(String name) {
        return tournamentRepository.findByName(name);
    }

    @Override
    public void saveTeamToTournament(List<Team> team, Tournament tournament) {
        List<Team> list = new LinkedList<Team>();
        teamRepository.save(team);
       // tournament.setTeams(team);
        tournamentRepository.save(tournament);

    }



    @Override
    @Transactional
    public void update(Tournament tournament) {
        System.out.println("dokonuje update");
        tournamentRepository.save(tournament);
    }

    @Override
    public void updateTournamentState(String stateOfTournament, long id) {
        tournamentRepository.updateTournamentState(stateOfTournament,id);
    }

    @Override
    public void updateTournament(int currentNumberOfTeam, long id) {

        Tournament tournament = tournamentRepository.getOne(id);
        if(tournament.getMaxNumberOfTeam() == currentNumberOfTeam) {
            updateTournamentState("In progress",id);
        }
        tournamentRepository.updateTournament(currentNumberOfTeam,id);
    }

    @Override
    public void setFixture(List<Team> teamList,Tournament tournament) {

        int numberOfRound = teamList.size()-1;
        int half = teamList.size()/2;
        Team stala = teamList.get(0);
        teamList.remove(0);
        int teamSize = teamList.size();

        for(int day=0;day<numberOfRound;day++)
        {
            Game game = new Game();
            System.out.println("Kolejka "+day+1);
            game.setKolejka(day+1);
            int teamIdx = day % teamSize;
            System.out.println("{0} vs {1} " + stala.getName() + teamList.get(teamIdx).getName() );
            game.setHome(stala);
            game.setAway(teamList.get(teamIdx));
            game.setTournament(tournament);
            gameRepository.save(game);

            for(int idx=1;idx<half;idx++){

                game.setKolejka(day+1);
                int firstTeam = (day+idx) % teamSize;
                int secondTeam = (day + teamSize -idx) % teamSize;
                System.out.println("{0} vs {1} " + teamList.get(firstTeam).getName() + teamList.get(secondTeam).getName());
                game.setHome(teamList.get(firstTeam));
                game.setAway(teamList.get(secondTeam));
                game.setTournament(tournament);
                gameRepository.save(game);
            }
        }

    }
}
