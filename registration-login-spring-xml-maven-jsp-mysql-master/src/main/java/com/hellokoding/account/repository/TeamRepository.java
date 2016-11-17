package com.hellokoding.account.repository;

import com.hellokoding.account.model.Team;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by Piotrek on 15-Nov-16.
 */
public interface TeamRepository extends JpaRepository<Team, Long> {

}
