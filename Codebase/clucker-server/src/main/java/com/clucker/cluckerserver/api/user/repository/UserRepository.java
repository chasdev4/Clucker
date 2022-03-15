package com.clucker.cluckerserver.api.user.repository;

import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.repository.JpaRepositoryWithSpecification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface UserRepository extends JpaRepositoryWithSpecification<User, Integer> {

    Optional<User> findUserByUsername(String username);
    Optional<User> findUserByEmail(String email);

}
