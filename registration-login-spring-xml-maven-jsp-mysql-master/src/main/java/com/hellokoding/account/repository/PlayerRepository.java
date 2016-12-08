package com.hellokoding.account.repository;

import com.hellokoding.account.model.Player;
import com.hellokoding.account.model.Team;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by Piotrek on 18-Nov-16.
 */
public interface PlayerRepository extends JpaRepository<Player,Long> {
    List<Player> findByTeam(Team team);

}

