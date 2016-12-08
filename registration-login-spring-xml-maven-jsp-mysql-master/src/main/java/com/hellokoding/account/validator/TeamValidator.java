package com.hellokoding.account.validator;


import com.hellokoding.account.model.Team;
import com.hellokoding.account.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.List;
import java.util.regex.Pattern;

/**
 * Created by Piotrek on 02-Dec-16.
 */
@Component
public class TeamValidator implements Validator {

    @Autowired
    private TeamService teamService;

    private static String emailPattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$";

    @Override
    public void validate(Object o, Errors errors) {

        ValidationUtils.rejectIfEmptyOrWhitespace(errors,"name","NotEmpty");
        Team team = (Team)o;
        System.out.println(team.getName());

        //if(teamService.findAllByName(team.getName()))
         List<Team> list = teamService.findAllByName(team.getName());
        System.out.println(list.size());
        if(list.size()!= 0) {
            errors.rejectValue("name","T.teamForm");
        }



        if(team.getName().length()<5 || team.getName().length() > 32){
            errors.rejectValue("name", "Size.teamForm.name");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors,"emailContact","NotEmpty");

        if(!isValidEmailAddress(team.getEmailContact())) {
            errors.rejectValue("emailContact","Email.teamForm.emailContact");
        }
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return Team.class.equals(aClass);
    }

    public boolean isValidEmailAddress(String email) {
        java.util.regex.Pattern p = java.util.regex.Pattern.compile(emailPattern);
        java.util.regex.Matcher m = p.matcher(email);
        return m.matches();
    }
}
