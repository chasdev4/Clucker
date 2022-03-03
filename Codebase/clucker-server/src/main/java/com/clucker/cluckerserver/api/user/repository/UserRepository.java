package com.clucker.cluckerserver.api.user.repository;

import com.clucker.cluckerserver.model.User;
import com.clucker.cluckerserver.repository.JpaRepositoryWithSpecification;

import java.util.Optional;

public interface UserRepository extends JpaRepositoryWithSpecification<User, Integer> {

    Optional<User> findUserByUsername(String username);
    Optional<User> findUserByEmail(String email);

}
