package com.clucker.cluckerserver.search;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.persistence.metamodel.Attribute;
import java.util.Arrays;

@RequiredArgsConstructor
@Getter
public class SimpleSearchSpecification<T> implements Specification<T> {

    private final String searchString;

    @Override
    public Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder cb) {

        if (StringUtils.isBlank(searchString)) {
            return null;
        }

        String[] searchTerms = getSearchString().split("[\\s,]");

        Predicate[] predicates = Arrays.stream(searchTerms)
                .map(String::toLowerCase)
                .flatMap(searchTerm -> root.getModel().getAttributes().stream()
                        .filter(attribute -> attribute.getJavaType() == String.class)
                        .map(Attribute::getName)
                        .map(attributeName -> cb.like(cb.lower(root.get(attributeName)), "%" + searchTerm + "%")))
                .toArray(Predicate[]::new);

        return cb.or(predicates);
    }
}
