package com.hellokoding.account.service;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.User;
import com.hellokoding.account.repository.GameRepository;
import com.hellokoding.account.repository.TeamRepository;
import com.hellokoding.account.repository.TournamentRepository;
import com.hellokoding.account.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by Piotrek on 16-Nov-16.
 */
@Service
public class TournamentServiceImpl implements TournamentService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private TournamentRepository tournamentRepository;

    @Autowired
    private SecurityService securityService;

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
        tournamentRepository.save(tournament);
    }

    @Override
    public Tournament getTournament(long tournamentId) {
        System.out.println("weszlo?");
        return tournamentRepository.findOne(tournamentId);
    }

    @Override
    public Tournament findByName(String name) {
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
    public void setFixture(List<Team> teamList,Tournament tournament,int frequency,int numberOfRounds) {

        int numberOfRound = (teamList.size()-1)*numberOfRounds;
        int half = teamList.size()/2;
        Team stala = teamList.get(0);
        teamList.remove(0);
        int teamSize = teamList.size();

        for(int day=0;day<numberOfRound;day++)
        {
            Game game = new Game();

            if(day==0){
                game.setDate(tournament.getDateOfBegining());
            } else {
                game.setDate(addDays(tournament.getDateOfBegining(),(day)*frequency));
            }
            game.setRound(day+1);
            int teamIdx = day % teamSize;

            if(day >= numberOfRound/2){
                game.setHome(teamList.get(teamIdx));
                game.setAway(stala);
            }else {
                game.setHome(stala);
                game.setAway(teamList.get(teamIdx));
            }
            game.setTournament(tournament);
            game.setGoals_home(-1);
            game.setGoals_away(-1);
            gameRepository.save(game);

            for(int idx=1;idx<half;idx++){

                game.setRound(day+1);
                int firstTeam = (day+idx) % teamSize;
                int secondTeam = (day + teamSize -idx) % teamSize;
                if(day > numberOfRound/2){
                    game.setHome(teamList.get(secondTeam));
                    game.setAway(teamList.get(firstTeam));
                }
                else {
                    game.setHome(teamList.get(firstTeam));
                    game.setAway(teamList.get(secondTeam));
                }

                game.setGoals_away(-1);
                game.setGoals_home(-1);
                game.setTournament(tournament);
                gameRepository.save(game);
            }
        }

    }
    private static Date addDays(Date date,int days) {
        Calendar cal = Calendar.getInstance();
        cal.setTime( date );
        cal.add(Calendar.DATE,days);
        return cal.getTime();
    }
    public List<Tournament> findByUser(User user) {
       return tournamentRepository.findByUser(userRepository.findByUsername(securityService.findLoggedInUsername()));
    }


}
