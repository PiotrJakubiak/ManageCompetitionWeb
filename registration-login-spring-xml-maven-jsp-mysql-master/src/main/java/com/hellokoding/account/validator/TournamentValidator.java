package com.hellokoding.account.validator;


import com.hellokoding.account.DTO.TournamentDTO;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.User;
import com.hellokoding.account.service.SecurityService;
import com.hellokoding.account.service.TournamentService;
import com.hellokoding.account.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.auditing.DateTimeProvider;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * Created by Piotrek on 22-Nov-16.
 */
@Component
public class TournamentValidator implements Validator {

    @Autowired
    private TournamentService tournamentService;

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Override
    public boolean supports(Class<?> aClass) {
        return TournamentDTO.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {

        TournamentDTO tournament = (TournamentDTO)o;

      //  if(tournamentService.findByName(tournament.getName()).size() != 0){
        //    errors.rejectValue("name","T.tournamentForm");
       // }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors,"name","NotEmpty");

        if(tournament.getName().length()<5 || tournament.getName().length() > 32){
            errors.rejectValue("name", "Size.tournamentForm.name");
        }

        if(tournament.getMaxNumberOfTeam() == 0){
            errors.rejectValue("maxNumberOfTeam", "NotEmpty");
        }

        ValidationUtils.rejectIfEmpty(errors,"dateOfBegining","NotEmpty");

        User user =userService.findByUsername(securityService.findLoggedInUsername());
        if(!user.getBirthDay().equals(new Date("2000/02/02"))) {
            errors.rejectValue("isOlder18","Not18Year");
            System.out.println("gowno");
        }

       // String tmpDate = tournament.getDateOfBegining().replaceAll("/","-");

       // if(!tmpDate.isEmpty()) {
         //   if(!LocalDate.parse(tmpDate).isAfter(timeNow)){
         //       errors.rejectValue("dateOfBegining", "Size.tournamentForm.dateOfBegining");
          //  }
       // }


        ValidationUtils.rejectIfEmpty(errors,"typeTournament","NotEmpty");

    }

}
