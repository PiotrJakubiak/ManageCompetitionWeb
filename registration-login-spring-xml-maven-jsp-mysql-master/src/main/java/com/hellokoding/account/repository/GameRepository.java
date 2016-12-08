package com.hellokoding.account.repository;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Tournament;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by Piotrek on 05-Dec-16.
 */
public interface GameRepository extends JpaRepository<Game, Long> {

    List<Game> findAllByTournament(Tournament tournament);
}
