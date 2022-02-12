package com.clucker.cluckerserver.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

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

    @NotNull
    private String password;

    @CreationTimestamp
    private LocalDateTime joined;

    @UpdateTimestamp
    private LocalDateTime lastModified;

    private LocalDateTime lastLogin;

    private boolean enabled;

}
