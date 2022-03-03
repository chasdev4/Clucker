package com.clucker.cluckerserver.api.cluck.repository;

import com.clucker.cluckerserver.model.Comment;
import com.clucker.cluckerserver.repository.JpaRepositoryWithSpecification;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface CommentRepository extends JpaRepositoryWithSpecification<Comment, UUID> {

    Page<Comment> findCommentsByCluckId(UUID cluckId, Pageable pageable);

}
