package com.hellokoding.account.web;

import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.User;
import com.hellokoding.account.service.SecurityService;
import com.hellokoding.account.service.TeamService;
import com.hellokoding.account.service.TournamentService;
import com.hellokoding.account.service.UserService;
import com.hellokoding.account.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;


@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private TeamService teamService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private TournamentService tournamentService;

        @RequestMapping(value = "/registration", method = RequestMethod.GET)
        public String registration(Model model) {
            model.addAttribute("userForm", new User());

            return "registration";
        }

        @RequestMapping(value = "/registration", method = RequestMethod.POST)
        public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
            userValidator.validate(userForm, bindingResult);

            if (bindingResult.hasErrors()) {
                return "registration";
            }

            userService.save(userForm);

            securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

            return "redirect:/welcome";
        }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Your username and password is invalid.");

        if (logout != null)
            model.addAttribute("message", "You have been logged out successfully.");
        Iterable<Team> teamList = teamService.findAllTeams();
        Iterable<Tournament> tournamentsList = tournamentService.findAllTournaments();
        model.addAttribute("teamsList",teamList);
        model.addAttribute("tournamentsList",tournamentsList);
        return "login";
    }


    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model) {
        teamService.findAllTeams();
        return "welcome";
    }


    @RequestMapping(value = "/createNewTeam", method = RequestMethod.GET)
    public String createNewTeam(Model model) {
        Team team = new Team();
        model.addAttribute("teamForm", team);
        return "createNewTeam";
    }
    @RequestMapping(value = "/createNewTeam", method = RequestMethod.POST)
    public String createNewTeam(@ModelAttribute("teamForm") Team teamForm, BindingResult bindingResult, Model model) {

        teamForm.setUser(userService.findByUsername(securityService.findLoggedInUsername()));
        System.out.println("Z CONTROLLERA " + teamForm.getName()+ teamForm.getUser());
        teamService.save(teamForm);



        return "redirect:/welcome";
    }
    @RequestMapping(value = "/createNewTournament", method = RequestMethod.GET)
    public String createNewTournament(Model model) {
        Tournament tournament = new Tournament();

        model.addAttribute("tournamentForm", tournament);
        return "createNewTournament";
    }
    @RequestMapping(value = "/createNewTournament", method = RequestMethod.POST)
    public String createNewTournament(@ModelAttribute("tournamentForm") Tournament tournamentForm, BindingResult bindingResult, Model model) {
        tournamentService.save(tournamentForm);
        return "redirect:/welcome";
    }

    @RequestMapping(value = "/tournamentId={id}", method = RequestMethod.GET)
    public ModelAndView viewFixedDepositDetails(@PathVariable("id") long id,RedirectAttributes redir) {
        System.out.println("123");
        Tournament fixedDepositDetails = tournamentService.getTournament(id);

        System.out.println(fixedDepositDetails);
        ModelMap modelMap = new ModelMap();
        modelMap.addAttribute(fixedDepositDetails);
        redir.addFlashAttribute("tournament",fixedDepositDetails);
        return new ModelAndView("list", modelMap);
    }
    @RequestMapping(value = "/tournamentId={id}", method = RequestMethod.POST)
    public String viewFixedDepositDetails(RedirectAttributes redir) {

        System.out.println("lalala");
        return "redirect:/list";

    }

    @ExceptionHandler
    public String handleException(Exception ex) {
        return "error";
    }


}
