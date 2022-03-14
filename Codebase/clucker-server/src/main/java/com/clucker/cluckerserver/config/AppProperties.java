package com.clucker.cluckerserver.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "app")
@Getter
@Setter
public class AppProperties {

    private String version;
    private String[] allowAllPost;
    private String[] allowAllGet;
    private String[] allowAllPut;
    private Security security = new Security();

    @Getter
    @Setter
    public static class Security {

        private String jwtSecretKey;
        private long jwtExpirationTime;

    }

}
