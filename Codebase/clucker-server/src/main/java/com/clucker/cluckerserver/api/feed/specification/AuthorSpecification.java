package com.clucker.cluckerserver.api.feed.specification;

import com.clucker.cluckerserver.model.Cluck;
import com.clucker.cluckerserver.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

@RequiredArgsConstructor
public class AuthorSpecification implements Specification<Cluck> {

    private final List<User> authors;

    @Override
    public Predicate toPredicate(Root<Cluck> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {
        if (authors != null && authors.isEmpty()) {
            return root.get("author").in(authors);
        } else {
            return criteriaBuilder.and();
        }
    }
}
