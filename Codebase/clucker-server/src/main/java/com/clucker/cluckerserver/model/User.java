package com.clucker.cluckerserver.model;

import com.clucker.cluckerserver.dto.validation.annotation.ValidCluck;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.validator.constraints.URL;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Set;

@Entity
@Getter
@Setter
public class User {

    @Id
    @GeneratedValue
    private Integer id;

    @NotNull
    @Enumerated(EnumType.STRING)
    private UserRole role;

    @Column(unique = true)
    @NotNull
    private String username;

    @Email
    @NotNull
    @Column(unique = true)
    private String email;

    @JsonIgnore
    @NotNull
    private String password;

    @ValidCluck
    private String bio;

    @URL
    private String avatarImage;

    @Max(360)
    private double avatarHue;

    @CreationTimestamp
    private OffsetDateTime joined;

    @UpdateTimestamp
    private OffsetDateTime lastModified;

    private OffsetDateTime lastLogin;

    private boolean enabled;

    @JsonIgnore
    @OneToMany(mappedBy = "author")
    private List<Cluck> clucks = Collections.emptyList();

    @JsonIgnore
    @OneToMany(mappedBy = "author")
    private List<Comment> comments = Collections.emptyList();

    @JsonIgnore
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            joinColumns = @JoinColumn(name = "follower_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<User> followers = Collections.emptyList();

    @JsonIgnore
    @ManyToMany(mappedBy = "followers")
    private List<User> following = Collections.emptyList();

    @JsonIgnore
    @ManyToMany
    @JoinTable(
            joinColumns = @JoinColumn(name = "cluck_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private Set<Cluck> likedClucks = Collections.emptySet();

    @JsonIgnore
    @ManyToMany
    @JoinTable(
            joinColumns = @JoinColumn(name = "cluck_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private Set<Cluck> dislikedClucks = Collections.emptySet();

    @Transient
    public int getEggRating() {
        return getClucks().stream()
                .mapToInt(Cluck::getEggRating)
                .sum();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return getId().equals(user.getId()) && getUsername().equals(user.getUsername()) && getEmail().equals(user.getEmail());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getUsername(), getEmail());
    }
}
