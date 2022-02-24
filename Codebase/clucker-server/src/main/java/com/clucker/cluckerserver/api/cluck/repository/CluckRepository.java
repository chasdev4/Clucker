package com.clucker.cluckerserver.api.cluck.repository;

import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.repository.JpaRepositoryWithSpecification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.UUID;

public interface CluckRepository extends JpaRepositoryWithSpecification<Cluck, UUID> {
    Page<Cluck> getAllByAuthorId(int id, Pageable pageable);
}
