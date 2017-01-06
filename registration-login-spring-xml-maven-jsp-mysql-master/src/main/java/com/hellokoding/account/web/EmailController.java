package com.hellokoding.account.web;

import com.hellokoding.account.DTO.EmailDTO;
import com.hellokoding.account.service.EmailAPI;
import com.hellokoding.account.service.SecurityService;
import com.hellokoding.account.service.TeamService;
import com.hellokoding.account.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Created by Piotrek on 13-Dec-16.
 */
@Controller
public class EmailController {

    @Autowired
    private EmailAPI emailAPI;
    @Autowired
    private TeamService teamService;
    @Autowired
    private UserService userService;
    @Autowired
    private SecurityService securityService;

    @RequestMapping(value="/sendEmailId={id}", method = RequestMethod.GET)
    private String sendEmail(@PathVariable("id") long id,  RedirectAttributes redir) {

        EmailDTO emailDTO = new EmailDTO();
        emailDTO.setId(id);

        redir.addFlashAttribute("emailDTO",emailDTO);
        return "redirect:sendEmail";
    }

    @RequestMapping(value = "/sendEmail", method = RequestMethod.GET)
    public String createNewTournament(@ModelAttribute("emailDTO") EmailDTO emailDTO, RedirectAttributes redir, Model model) {

        return "sendEmail";
    }
    @RequestMapping(value = "/sendMessage", method = RequestMethod.POST)
    public String sendMessage(@ModelAttribute("emailDTO")EmailDTO emailDTO, Model model, RedirectAttributes redir) {

        System.out.println(emailDTO.getId());
        System.out.println(emailDTO.getSubject());
        System.out.println(emailDTO.getText());

        emailAPI.crunchifyReadyToSendEmail(teamService.findById(emailDTO.getId()).getEmailContact(),
                                             userService.findByUsername(securityService.findLoggedInUsername()).getEmail(),emailDTO.getSubject(),emailDTO.getText());
        return "viewChoosenTournament";
    }

}
