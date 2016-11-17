package com.hellokoding.account.repository;

import com.hellokoding.account.model.Tournament;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Piotrek on 16-Nov-16.
 */
public interface TournamentRepository extends JpaRepository<Tournament,Long> {
}
