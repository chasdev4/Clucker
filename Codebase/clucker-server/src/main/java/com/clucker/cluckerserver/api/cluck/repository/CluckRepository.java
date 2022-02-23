package com.clucker.cluckerserver.api.cluck.repository;

import com.clucker.cluckerserver.model.Cluck;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface CluckRepository extends JpaRepository<Cluck, UUID> {
    Page<Cluck> getAllByAuthorUsername(String username, Pageable pageable);
}
