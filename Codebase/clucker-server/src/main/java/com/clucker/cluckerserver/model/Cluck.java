package com.clucker.cluckerserver.model;

import com.clucker.cluckerserver.dto.validation.annotation.ValidCluck;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Cluck {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator"
    )
    @Type(type = "org.hibernate.type.UUIDCharType")
    @Column(columnDefinition = "CHAR(36)", updatable = false, nullable = false)
    private UUID id;

    @ValidCluck(message = "Cluck cannot exceed 6 words.")
    @NotNull
    private String body;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id", nullable = false, updatable = false)
    private User author;

    @CreationTimestamp
    private OffsetDateTime posted;

    @UpdateTimestamp
    private OffsetDateTime lastModified;

    @OneToMany(mappedBy = "cluck")
    @Builder.Default
    private List<Comment> comments = Collections.emptyList();

    @ManyToMany(mappedBy = "likedClucks")
    @Builder.Default
    private Set<User> likeUsers = Collections.emptySet();

    @ManyToMany(mappedBy = "dislikedClucks")
    @Builder.Default
    private Set<User> dislikeUsers = Collections.emptySet();

    @Transient
    public int getEggRating() {
        return getLikeUsers().size() - getDislikeUsers().size();
    }
}
