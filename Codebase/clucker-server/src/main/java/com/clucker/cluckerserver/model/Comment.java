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
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.UUID;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Comment {

    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator"
    )
    @Type(type = "org.hibernate.type.UUIDCharType")
    @Column(columnDefinition = "CHAR(36)", updatable = false, nullable = false)
    private UUID id;

    @NotNull
    @ValidCluck(message = "Comment cannot succeed 6 words.")
    private String body;

    @ManyToOne(optional = false)
    @JoinColumn(name = "cluck_id", updatable = false, nullable = false)
    private Cluck cluck;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id", updatable = false, nullable = false)
    private User author;

    @CreationTimestamp
    private OffsetDateTime posted;

    @UpdateTimestamp
    private OffsetDateTime lastModified;

}
