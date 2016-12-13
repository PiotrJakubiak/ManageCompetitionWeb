package com.hellokoding.account.validator;


import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.service.TournamentService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Override
    public boolean supports(Class<?> aClass) {
        return Tournament.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {

        Tournament tournament = (Tournament)o;

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

       // LocalDate timeNow = LocalDate.now();
       // String tmpDate = tournament.getDateOfBegining().replaceAll("/","-");

       // if(!tmpDate.isEmpty()) {
         //   if(!LocalDate.parse(tmpDate).isAfter(timeNow)){
         //       errors.rejectValue("dateOfBegining", "Size.tournamentForm.dateOfBegining");
          //  }
       // }


        ValidationUtils.rejectIfEmpty(errors,"typeTournament","NotEmpty");

    }
}
