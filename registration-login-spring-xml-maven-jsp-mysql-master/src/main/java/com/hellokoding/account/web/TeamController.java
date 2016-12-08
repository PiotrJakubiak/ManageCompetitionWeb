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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

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

    @RequestMapping(value = "/createNewTeam", method = RequestMethod.GET)
    public String createNewTeam(Model model) {
        Team team = new Team();

        model.addAttribute("teamForm", team);


        return "createNewTeam";
    }
    @RequestMapping(value = "/createNewTeam", method = RequestMethod.POST)
    public String createNewTeam(@ModelAttribute("teamForm") Team teamForm, BindingResult bindingResult, Model model, RedirectAttributes redir) {

        teamValidator.validate(teamForm,bindingResult);

        if (bindingResult.hasErrors()) {
            return "createNewTeam";
        }


        teamForm.setUser(userService.findByUsername(securityService.findLoggedInUsername()));
        teamService.save(teamForm);

        ModelMap modelMap = new ModelMap();
        modelMap.addAttribute(teamForm);
        redir.addFlashAttribute("team",teamForm);

        return "redirect:manageTeam";

    }
    @RequestMapping(value="/manageTeam", method = RequestMethod.GET)
    public String manageTeam(@ModelAttribute("team") Team teamForm, HttpServletRequest request, Model model) {

        request.getSession().setAttribute("team",teamService.findById(teamForm.getId()));

        model.addAttribute("team",teamForm);

        return "manageTeam";
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
