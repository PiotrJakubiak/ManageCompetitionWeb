package com.hellokoding.account.web;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.service.GameService;
import com.hellokoding.account.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by Piotrek on 30-Nov-16.
 */
@Controller
public class MatchController {


    @RequestMapping(value = "/addMatch", method = RequestMethod.GET)
    public String addMatch()
    {

        return "addMatch";
    }

}
