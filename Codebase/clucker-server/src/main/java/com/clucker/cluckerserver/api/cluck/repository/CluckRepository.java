package com.clucker.cluckerserver.api.cluck.repository;

import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.repository.JpaRepositoryWithSpecification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface CluckRepository extends JpaRepositoryWithSpecification<Cluck, UUID> {
    Page<Cluck> getAllByAuthorId(int id, Pageable pageable);
}
