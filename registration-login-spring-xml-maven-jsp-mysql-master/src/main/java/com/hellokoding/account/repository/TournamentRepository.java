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
 * Created by Piotrek on 16-Nov-16.
 */

public interface TournamentRepository extends JpaRepository<Tournament,Long> {
    List<Tournament> findByName(String name);
    long count();
    // Zapytanie zwracajace druzyny w turnieju po nazwie
    //List<Tournament> findByTeams_Name(String name);
    @Modifying
    @Transactional
    @Query("UPDATE Tournament t SET t.currentNumberOfTeam = :currentNumberOfTeam WHERE t.id = :id")
    void updateTournament(@Param("currentNumberOfTeam") int currentNumberOfTeam, @Param("id") long id);

    @Modifying
    @Transactional
    @Query("UPDATE Tournament t SET t.stateOfTournament = :stateOfTournament WHERE t.id = :id")
    void updateTournamentState(@Param("stateOfTournament") String stateOfTournament, @Param("id") long id);


}
