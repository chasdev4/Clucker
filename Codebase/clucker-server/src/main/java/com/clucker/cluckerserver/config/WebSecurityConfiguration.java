package com.clucker.cluckerserver.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter {

    private final AppProperties appProperties;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().and().csrf().disable()
                .httpBasic().disable();

        allowGetRequests(http);
        allowPostRequests(http);

        http.authorizeRequests()
                .anyRequest()
                .authenticated();
    }

    private void allowPostRequests(HttpSecurity http) throws Exception {
        if (appProperties.getAllowAllPost() == null ||
            appProperties.getAllowAllPost().length == 0)
            return;

        http.authorizeRequests()
                .antMatchers(HttpMethod.POST, appProperties.getAllowAllPost())
                .permitAll();
    }

    private void allowGetRequests(HttpSecurity http) throws Exception {
        if (appProperties.getAllowAllGet() == null ||
                appProperties.getAllowAllGet().length == 0)
            return;

        http.authorizeRequests()
                .antMatchers(HttpMethod.GET, appProperties.getAllowAllGet())
                .permitAll();
    }
}
