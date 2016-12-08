package com.hellokoding.account.repository;

import com.hellokoding.account.model.Team;

import com.hellokoding.account.model.Tournament;
import com.hellokoding.account.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Piotrek on 15-Nov-16.
 */

public interface TeamRepository extends JpaRepository<Team, Long> {
    Team findById(long id);
    List<Team> findByUser(User user);
    Team findByName(String name);
    List<Team> findAllByName(String name);
    List<Team> findByUserAndCategory(User user,String category);
    //zlicza zespoly by turnieju po wskazaniu id turnieju
    //int countByTournaments_id(long id);

    //zwraca liste zespolow w turnieju po wskazaniu id turnieju
  // List<Team> findByTournaments_Team(long id);


}
