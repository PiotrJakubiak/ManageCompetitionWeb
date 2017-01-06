package com.hellokoding.account.repository;

import com.hellokoding.account.model.Game;
import com.hellokoding.account.model.Team;
import com.hellokoding.account.model.Tournament;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

/**
 * Created by Piotrek on 05-Dec-16.
 */
public interface GameRepository extends JpaRepository<Game, Long> {

    List<Game> findAllByTournament(Tournament tournament);

    @Query("select g from Game g where g.tournament = :tournament and (g.goals_home=-1 or g.goals_away=-1) ")
    List<Game> findNextGame(@Param("tournament")Tournament tournament,Pageable pageable);
    /*
    @Query("select g from Game g where g.tournament = :tournament and g.date <= :date")
    List<Game> findLastGames(@Param("tournament")Tournament tournament,@Param("date") Date date,Pageable pageable);
    */
    @Query("select g from Game g where g.tournament = :tournament and (g.goals_home<>-1 or g.goals_away<>-1) order by g.date desc")
    List<Game> findLastGames(@Param("tournament")Tournament tournament,Pageable pageable);

    @Query("select g from Game g where g.tournament = :tournament and (g.home=:team or g.away=:team)")
    List<Game> findAllByTeam(@Param("tournament")Tournament tournament,@Param("team") Team team);

    @Query("select g from Game g where (g.home=:team or g.away=:team)")
    List<Game> findAllByTeam(@Param("team") Team team);
}
