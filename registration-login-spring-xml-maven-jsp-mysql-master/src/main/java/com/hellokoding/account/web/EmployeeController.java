package com.hellokoding.account.web;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.TournamentTeam;
import com.hellokoding.account.service.GameService;
import com.hellokoding.account.service.TeamService;
import com.hellokoding.account.service.TournamentService;
import com.hellokoding.account.service.TournamentTeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Piotrek on 09-Dec-16.
 */
@Controller
public class EmployeeController {

    @Autowired
    private TournamentTeamService tournamentTeamService;

    @Autowired
    private TournamentService tournamentService;

    @Autowired
    private GameService gameService;

    @RequestMapping(value="/employee/lol", method = RequestMethod.POST)
    public void add(@RequestParam  String teamList,@RequestParam String numberOfrounds,@RequestParam String frequency,HttpServletResponse response) {

        System.out.println(numberOfrounds);

        Tournament tournament =  tournamentService.findByName(teamList);

        if(tournament.getCurrentNumberOfTeam() == tournament.getMaxNumberOfTeam() && gameService.findAllByTournament(tournament).size()== 0) {
            List<TournamentTeam> list2 = tournamentTeamService.findByTournament(tournament);
            List<Team> listTeam = new ArrayList<>();

            for(TournamentTeam tournamentTeam : list2){
                listTeam.add(tournamentTeam.getTeam());
            }
            tournamentService.setFixture(listTeam,tournament,Integer.valueOf(frequency),Integer.valueOf(numberOfrounds));
        }

    }
    @RequestMapping(value="/schedule/tournamentId={id}", method = RequestMethod.GET)
    public ModelAndView viewSchedule(@PathVariable("id") long id) {

        ModelMap modelMap = new ModelMap();

        Tournament tournament =  tournamentService.getTournament(id);
        Iterable<Game> gameList = gameService.findAllByTournament(tournament);
        modelMap.addAttribute("tournament",tournament);
        modelMap.addAttribute("gameList",gameList);

        return new ModelAndView("schedule", modelMap);
    }

    @RequestMapping(value="/fixture/lol", method = RequestMethod.POST)
    public void addFixture(@RequestParam  String gameId,@RequestParam String fixtureHome,@RequestParam String fixtureAway,HttpServletResponse response) {

        Game game = gameService.findById(Long.valueOf(gameId));
        game.setGoals_home(Integer.valueOf(fixtureHome));
        game.setGoals_away(Integer.valueOf(fixtureAway));
        gameService.save(game);

    }
}

