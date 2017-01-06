package com.hellokoding.account.validator;

import com.hellokoding.account.DTO.TournamentTeamDTO;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.TournamentTeam;
import com.hellokoding.account.service.TournamentService;
import com.hellokoding.account.service.TournamentTeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Piotrek on 02-Dec-16.
 */
@Component
public class SelectTeamValidator implements Validator {

    @Autowired
    private TournamentTeamService tournamentTeamService;
    @Autowired
    private TournamentService tournamentService;

    @Override
    public boolean supports(Class<?> aClass) {
        return TournamentTeamDTO.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {

        TournamentTeamDTO tournamentTeam = (TournamentTeamDTO)o;

        long id = Long.parseLong(tournamentTeam.getTournament());

        List<TournamentTeam> list2 = tournamentTeamService.findByTournament(tournamentService.getTournament(id));
        List<Team> listTeam = new ArrayList<>();

        for(TournamentTeam tournamentT : list2){
            listTeam.add(tournamentT.getTeam());

        }
        for(Team team : listTeam){
            if(team.getName().equals(tournamentTeam.getTeam())) {
                errors.rejectValue("team", "Select.selectTeam.team");
            }
        }


    }
}
