package com.hellokoding.account.web;

import com.hellokoding.account.DTO.TournamentTeamDTO;
import com.hellokoding.account.model.*;
import com.hellokoding.account.service.*;
import com.hellokoding.account.validator.SelectTeamValidator;
import com.hellokoding.account.validator.TournamentValidator;
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
import java.util.*;


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
    private TournamentValidator tournamentValidator;

    @Autowired
    private TournamentService tournamentService;

    @Autowired
    private PlayerService playerService;

    @Autowired
    private TournamentTeamService tournamentTeamService;

    @Autowired
    private SelectTeamValidator selectTeamValidator;

    @Autowired
    private GameService gameService;

    @Autowired
    private EmailAPI emailAPI;



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
        List<Tournament> list = tournamentService.findAllTournaments();
        Iterable<Tournament> tournamentsList = tournamentService.findAllTournaments();

        model.addAttribute("teamsList",teamList);
        model.addAttribute("tournamentsList",tournamentsList);
        return "login";
    }


    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model) {
        Iterable<Tournament> tournamentsList = tournamentService.findAllTournaments();
        Iterable<Team> teamList = teamService.findAllTeams();
        for(Tournament tournament : tournamentsList) {
            tournamentService.getTournament(tournament.getId()).setStateOfTournament("In progress");
        }
        model.addAttribute("tournamentsList", tournamentsList);
        model.addAttribute("teamsList",teamList);
        return "welcome";
    }
    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.POST)
    public String welcome() {

        Iterable<Tournament> tournamentsList = tournamentService.findAllTournaments();

        for(Tournament tournament : tournamentsList) {
            tournamentService.getTournament(tournament.getId()).setStateOfTournament("In progress");
        }

        return "welcome";
    }

    @RequestMapping(value = "/createNewTournament", method = RequestMethod.GET)
    public String createNewTournament(Model model) {

        Tournament tournament = new Tournament();

        model.addAttribute("tournamentForm", tournament);
        return "createNewTournament";
    }
    @RequestMapping(value = "/createNewTournament", method = RequestMethod.POST)
    public String createNewTournament(@ModelAttribute("tournamentForm") Tournament tournamentForm, BindingResult bindingResult, Model model) {
        tournamentForm.setStateOfTournament("Oczekuje");
        tournamentForm.setUser(userService.findByUsername(securityService.findLoggedInUsername()));
        tournamentValidator.validate(tournamentForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "createNewTournament";
        }

        tournamentService.save(tournamentForm);
        return "redirect:/welcome";
    }

    @RequestMapping(value = "/viewTournament", method = RequestMethod.GET)
    public String viewTournament(Model model) {
        model.addAttribute("tournamentTeamDTO", new TournamentTeamDTO());

        return "viewTournament";
    }

    @RequestMapping(value = "/createNewPlayer", method = RequestMethod.GET)
    public String createNewPlayer( Model model) {

        model.addAttribute("tournamentTeamDTO", new TournamentTeamDTO());
        return "createNewPlayer";
    }

    @RequestMapping(value = "/createNewPlayer", method = RequestMethod.POST)
    public String createNewPlayer(@ModelAttribute("tournamentTeamDTO") TournamentTeamDTO teamTournamentDTO , BindingResult bindingResult, Model model) {
        long id = Long.parseLong(teamTournamentDTO.getTournament());

        selectTeamValidator.validate(teamTournamentDTO,bindingResult);

        if (bindingResult.hasErrors()) {
            return "viewTournament";
        }

        /*
        List<TournamentTeam> list2 = tournamentTeamService.findByTournament(tournamentService.getTournament(id));
        List<Team> listTeam = new ArrayList<>();

        for(TournamentTeam tournamentTeam : list2){
            listTeam.add(tournamentTeam.getTeam());

        }
       for(Team team : listTeam){
           if(team.getName().equals(teamTournamentDTO.getTeam())) {
                return "redirect:welcome";
            }
        }
        */
        tournamentTeamService.save(teamService.findByName(teamTournamentDTO.getTeam()),tournamentService.getTournament(id));
        return "redirect:welcome";
    }
    @RequestMapping(value = "/tournamentId={id}", method = RequestMethod.GET)
    public ModelAndView viewFixedDepositDetails(@PathVariable("id") long id,RedirectAttributes redir) {

        Tournament tournament = tournamentService.getTournament(id);
        Iterable<Team> list;
        List<TournamentTeam> list2 = tournamentTeamService.findByTournament(tournament);
        List<Team> listTeam = new ArrayList<>();

       for(TournamentTeam tournamentTeam : list2){
          listTeam.add(tournamentTeam.getTeam());

        }
        list = listTeam;
        ModelMap modelMap = new ModelMap();
        modelMap.addAttribute(tournament);
        modelMap.addAttribute("teamList",list);

        redir.addFlashAttribute("tournament",tournament);
        redir.addFlashAttribute("teamList",list);


        Iterable<Game> gameList = gameService.findNextGame(tournament,new Date());
        Iterable<Game> lastGamesList = gameService.findLastGames(tournament,new Date());
        List<TeamStats> tournamentTable = new ArrayList<TeamStats>();
        for(Team team : listTeam) {
            System.out.println(team.getName());
            List<Game> allGamesByTeam = gameService.findAllByTeam(tournament,team);
            System.out.println("llllll "+allGamesByTeam.size());
            int match=0,win=0,rem=0,por=0,punkty=0;
            for(Game game : allGamesByTeam) {
                match++;
                if(team.getId() == game.getHome().getId()) {
                    System.out.println("weszlo0");
                    if(game.getGoals_home() > game.getGoals_away()) {
                        System.out.println("weszlo1");
                        win++;
                    } else if(game.getGoals_home() == game.getGoals_away()) {
                        System.out.println("weszlo2");
                        rem++;
                    } else if(game.getGoals_home() < game.getGoals_away()) {
                        System.out.println("weszlo3");
                        por++;
                    }
                } else {
                    if(game.getGoals_home() > game.getGoals_away()) {
                        por++;
                    } else if(game.getGoals_home() == game.getGoals_away()) {
                        rem++;
                    } else if(game.getGoals_home() < game.getGoals_away()){
                        win++;
                    }
                }
            }
            TeamStats teamStats = new TeamStats();
            teamStats.setName(team.getName());
            teamStats.setCountMatch(match);
            teamStats.setCountWin(win);
            teamStats.setCountDraw(rem);
            teamStats.setCountFail(por);
            punkty=3*win+rem;
            teamStats.setCountPoints(punkty);
            tournamentTable.add(teamStats);

        }
        //emailAPI.crunchifyReadyToSendEmail("piotrekjakubiak1994@gmail.com","alfredoooooo@gmail.com","test","akuku!");
        Collections.sort(tournamentTable, new Comparator<TeamStats>() {
            @Override public int compare(TeamStats p1, TeamStats p2) {
                return p2.getCountPoints() - p1.getCountPoints(); // Ascending
            }

        });
        modelMap.addAttribute("tournamentTable",tournamentTable);
        modelMap.addAttribute("gameList",gameList);
        modelMap.addAttribute("lastGameList",lastGamesList);

        return new ModelAndView("viewChoosenTournament", modelMap);
    }

    @RequestMapping(value = "/viewTournamentId={id}", method = RequestMethod.GET)
    public String joinTournament(@PathVariable("id") long id,RedirectAttributes redir) {

        if(tournamentService.getTournament(id).getCurrentNumberOfTeam() < tournamentService.getTournament(id).getMaxNumberOfTeam() ) {
            Tournament tournament = tournamentService.getTournament(id);
            List<Team> list = teamService.findByUserAndCategory(userService.findByUsername(securityService.findLoggedInUsername()),tournament.getCategoryOfTournament());
            HashSet<String> userTeams = new LinkedHashSet<String>();
            for (Team team : list) {
                userTeams.add(team.getName());
            }
            Iterable<Team> teamList = teamService.findByUser(userService.findByUsername(securityService.findLoggedInUsername()));

            redir.addFlashAttribute("tournament", tournament);
            redir.addFlashAttribute("userTeams", userTeams);
            redir.addFlashAttribute("teamsList", list);
            return "redirect:viewTournament";
        } else {

            return "redirect:welcome";

        }
    }

    @RequestMapping(value="/createNewTeams", method = RequestMethod.GET)
    public void add(HttpServletRequest request)
            throws Exception {
        request.getSession().getAttribute("team");
        System.out.println("czy sie udalo?"+ request.getSession().getAttribute("team"));
        Team team = (Team) request.getSession().getAttribute("team");
        Player player = new Player();

        String name = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");

        player.setName(name);
        player.setLastName(lastName);
        player.setTeam(team);
        System.out.println(player.getName()+ " "+player.getLastName());
        playerService.save(player,team);
        //return employee;
    }

    @ExceptionHandler
    public String handleException(Exception ex) {
        return "error";
    }


    @RequestMapping(value = "/teamId={id}", method = RequestMethod.GET)
    public String viewTeam(@PathVariable("id") long id, RedirectAttributes redir) {

        Team team = teamService.findById(id);
        Iterable<Player> listPlayer = playerService.findByTeam(team);
        System.out.println("aaaaaaaaaaaaaaaaa"+team.getName());
        redir.addFlashAttribute("team",team);
        redir.addFlashAttribute("listPlayer",listPlayer);
        return "redirect:viewTeam";
    }
    @RequestMapping(value = "/viewTeam", method = RequestMethod.GET)
    public String viewChoosenTeam(RedirectAttributes redir) {

        System.out.println("pobieram " + redir.getFlashAttributes());

        return "viewTeam";
    }



}
