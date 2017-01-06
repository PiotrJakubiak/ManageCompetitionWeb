package com.hellokoding.account.web;

import com.hellokoding.account.DTO.TeamDTO;
import com.hellokoding.account.model.Player;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.service.PlayerService;
import com.hellokoding.account.service.SecurityService;
import com.hellokoding.account.service.TeamService;
import com.hellokoding.account.service.UserService;
import com.hellokoding.account.validator.TeamValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Piotrek on 29-Nov-16.
 */
@Controller
public class TeamController {

    @Autowired
    private TeamService teamService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private PlayerService playerService;

    @Autowired
    private TeamValidator teamValidator;

    @Autowired
    private UserService userService;

    private static List<Player> players = new ArrayList<Player>();

    static {
        players.add(new Player("", "", "Bramkarz" ,1 ,""));
        players.add(new Player("", "", "Obronca" ,2 ,""));
        players.add(new Player("", "", "Obronca" ,3 ,""));
        players.add(new Player("", "", "Obronca" ,4 ,""));
        players.add(new Player("", "", "Obronca" ,5 ,""));
        players.add(new Player("", "", "Pomocnik" ,6 ,""));
        players.add(new Player("", "", "Pomocnik" ,7 ,""));
        players.add(new Player("", "", "Pomocnik" ,8 ,""));
        players.add(new Player("", "", "Pomocnik" ,9 ,""));
        players.add(new Player("", "", "Napastnik" ,10 ,""));
        players.add(new Player("", "", "Napastnik" ,11 ,""));
    }

    @RequestMapping(value = "/createNewTeam", method = RequestMethod.GET)
    public ModelAndView createNewTeam(Model model) {

        TeamDTO team = new TeamDTO();
        team.setPlayers(players);

        return new ModelAndView ("createNewTeam","teamForm", team);
    }
    @RequestMapping(value = "/createNewTeam", method = RequestMethod.POST)
    public String createNewTeam(@ModelAttribute("teamForm") TeamDTO teamForm, BindingResult bindingResult, Model model, RedirectAttributes redir) {

        //teamValidator.validate(teamForm,bindingResult);

        if (bindingResult.hasErrors()) {
            return "createNewTeam";
        }

        List<Player> players = teamForm.getPlayers();
        Team team = new Team();
        team.setName(teamForm.getName());
        team.setEmailContact(teamForm.getEmailContact());
        team.setCategory(teamForm.getCategory());
        team.setUser(userService.findByUsername(securityService.findLoggedInUsername()));

        teamService.save(team);

        if(null != players && players.size() > 0) {
            //TeamController.players = players;
            for (Player p:players) {
                Player player = new Player();
                player.setName(p.getName());
                player.setLastName(p.getLastName());
                player.setPosition(p.getPosition());
                player.setNumber(p.getNumber());
                player.setTeam(team);
                playerService.save(player,team);
            }
        }

        return "redirect:welcome";

    }

    @RequestMapping(value = "/editTeamId={id}", method = RequestMethod.GET)
    public String editTeam(@PathVariable("id") long id, RedirectAttributes redir) {

        Team team = teamService.findById(id);

        redir.addFlashAttribute("team",team);

        return "redirect:editTeam";
    }

    @RequestMapping(value = "/editTeam", method = RequestMethod.GET)
    public String editChoosenTeam(Model model, RedirectAttributes redir) {

        model.addAttribute("teamDTO",new Team());
        System.out.println("pobieram " + redir.getFlashAttributes());

        return "editTeam";
    }
    @RequestMapping(value = "/saveEditTeam", method = RequestMethod.POST)
    public String saveEditTeam(@ModelAttribute("teamDTO")Team team, Model model, RedirectAttributes redir) {
        System.out.println("dokonuje zapisu!");
        teamService.update(team);
        return "redirect:welcome";
    }
}
