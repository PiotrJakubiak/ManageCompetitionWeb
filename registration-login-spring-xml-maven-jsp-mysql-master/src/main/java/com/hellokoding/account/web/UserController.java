package com.hellokoding.account.web;

import com.hellokoding.account.DTO.TournamentDTO;
import com.hellokoding.account.DTO.TournamentTeamDTO;
import com.hellokoding.account.model.*;
import com.hellokoding.account.service.*;
import com.hellokoding.account.validator.SelectTeamValidator;
import com.hellokoding.account.validator.TournamentValidator;
import com.hellokoding.account.validator.UserValidator;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
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

    @Autowired
    private RulesService rulesService;


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
            tournamentService.getTournament(tournament.getId()).setStateOfTournament("Aktywny");
        }
        model.addAttribute("tournamentsList", tournamentsList);
        model.addAttribute("teamsList",teamList);
        return "welcome";
    }
    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.POST)
    public String welcome() {

        Iterable<Tournament> tournamentsList = tournamentService.findAllTournaments();

        for(Tournament tournament : tournamentsList) {
            tournamentService.getTournament(tournament.getId()).setStateOfTournament("Aktywny");
        }

        return "welcome";
    }

    @RequestMapping(value = "/createNewTournament", method = RequestMethod.GET)
    public String createNewTournament(Model model) {

        //Tournament tournament = new Tournament();
        TournamentDTO tournamentDTO = new TournamentDTO();
       // model.addAttribute("tournamentForm", tournament);
        model.addAttribute("tournamentForm", tournamentDTO);
        return "createNewTournament";
    }
    @RequestMapping(value = "/createNewTournament", method = RequestMethod.POST)
    public String createNewTournament(@ModelAttribute("tournamentForm") TournamentDTO tournamentForm, BindingResult bindingResult, Model model) throws IOException {

        tournamentValidator.validate(tournamentForm, bindingResult);

        Tournament tournament = new Tournament();

        tournament.setStateOfTournament("Oczekuje");
        tournament.setUser(userService.findByUsername(securityService.findLoggedInUsername()));
        tournament.setName(tournamentForm.getName());
        tournament.setMaxNumberOfTeam(tournamentForm.getMaxNumberOfTeam());
        tournament.setTypeTournament(tournamentForm.getTypeTournament());
        tournament.setDateOfBegining(tournamentForm.getDateOfBegining());
        tournament.setCategoryOfTournament(tournamentForm.getCategoryOfTournament());
        tournament.setDescription(tournamentForm.getDescription());

        Rules rules = new Rules();

        MultipartFile file = tournamentForm.getFileData();
        byte [] byteArr= file.getBytes();

        rules.setFileName("Rules"+tournamentForm.getName());
        rules.setData(byteArr);
        if (bindingResult.hasErrors()) {
            return "createNewTournament";
        }
        rulesService.save(rules);
        tournament.setRules(rules);
        tournamentService.save(tournament);

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


        Iterable<Game> gameList = gameService.findNextGame(tournament);
        Iterable<Game> lastGamesList = gameService.findLastGames(tournament);
        List<TeamStats> tournamentTable = new ArrayList<TeamStats>();
        for(Team team : listTeam) {
            System.out.println(team.getName());
            List<Game> allGamesByTeam = gameService.findAllByTeam(tournament,team);

            int match=0,win=0,rem=0,por=0,punkty=0;
            for(Game game : allGamesByTeam) {
                if((game.getGoals_away()!=-1) || (game.getGoals_home()!=-1)){
                    match++;

                    if(team.getId() == game.getHome().getId()) {
                        if(game.getGoals_home() > game.getGoals_away()) {
                            win++;
                        } else if(game.getGoals_home() == game.getGoals_away()) {
                            rem++;
                        } else if(game.getGoals_home() < game.getGoals_away()) {
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
    public String joinTournament(@PathVariable("id") long id,RedirectAttributes redir) throws IOException {

        if(tournamentService.getTournament(id).getCurrentNumberOfTeam() < tournamentService.getTournament(id).getMaxNumberOfTeam() ) {
            Tournament tournament = tournamentService.getTournament(id);
            List<Team> list = teamService.findByUserAndCategory(userService.findByUsername(securityService.findLoggedInUsername()),tournament.getCategoryOfTournament());
            List<TournamentTeam> listTeamInTournament = tournamentTeamService.findByTournament(tournament);
            for(Team t : list) {
                for(TournamentTeam tt : listTeamInTournament) {
                    if(tt.getTeam().equals(t)) {
                        System.out.println("123456678909");
                        list.remove(t);
                    }
                }
            }

            HashSet<String> userTeams = new LinkedHashSet<String>();
            Rules rules = rulesService.findOne(tournament.getRules());
            InputStream inputStream = new ByteArrayInputStream(rules.getData());
            String stringRules = IOUtils.toString(inputStream);
            for (Team team : list) {
                userTeams.add(team.getName());
            }
            Iterable<Team> teamList = teamService.findByUser(userService.findByUsername(securityService.findLoggedInUsername()));
            redir.addFlashAttribute("rules",stringRules);
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

        List<TournamentTeam> tournamentTeamList = tournamentTeamService.findByTeam(team);
        List<Tournament> myTeamTournaments = new ArrayList<>();
        for(TournamentTeam tt: tournamentTeamList){
            myTeamTournaments.add(tt.getTournament());
        }

        Iterable<Tournament> listTournamentByTeam = myTeamTournaments;
        Iterable<Game> listGameByTeam = gameService.findAllByTeam(team);

        System.out.println(myTeamTournaments.size());
        redir.addFlashAttribute("team",team);
        redir.addFlashAttribute("listPlayer",listPlayer);
        redir.addFlashAttribute("listGameByTeam",listGameByTeam);
        redir.addFlashAttribute("listTournamentByTeam",listTournamentByTeam);
        return "redirect:viewTeam";
    }
    @RequestMapping(value = "/viewTeam", method = RequestMethod.GET)
    public String viewChoosenTeam(RedirectAttributes redir) {

        System.out.println("pobieram " + redir.getFlashAttributes());

        return "viewTeam";
    }

    @RequestMapping(value = {"/account"}, method = RequestMethod.GET)
    public ModelAndView account(Model model,RedirectAttributes redir) {

        ModelMap modelMap = new ModelMap();
        User user = userService.findByUsername(securityService.findLoggedInUsername());
        List<Tournament> tournamentList = tournamentService.findByUser(user);
        List<Team> teamList = teamService.findByUser(user);
        modelMap.addAttribute("user",user);
        modelMap.addAttribute("tournament", tournamentList);
        modelMap.addAttribute("team", teamList);

        return new ModelAndView("account", modelMap);
    }


}
