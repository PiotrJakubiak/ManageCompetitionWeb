package com.hellokoding.account.repository;

import com.hellokoding.account.model.TypeEvent;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by Piotrek on 05-Dec-16.
 */
public interface TypeEventRepository extends JpaRepository<TypeEvent,Long> {
}
