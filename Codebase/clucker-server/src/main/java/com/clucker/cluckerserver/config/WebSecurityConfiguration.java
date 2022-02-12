package com.clucker.cluckerserver.config;

import com.clucker.cluckerserver.security.filter.JwtProviderFilter;
import com.clucker.cluckerserver.security.filter.JwtTokenFilter;
import com.clucker.cluckerserver.security.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.Key;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Autowired
    private AppProperties appProperties;

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtTokenFilter tokenFilter;

    @Autowired
    private Key jwtKey;

    @Bean
    public JwtProviderFilter providerFilter() {
        return new JwtProviderFilter(jwtKey);
    }

    @Override
    @Bean
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.cors().and().csrf().disable()
                .httpBasic().disable()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);

        allowGetRequests(http);
        allowPostRequests(http);

        http.authorizeRequests()
                .anyRequest()
                .authenticated()
                .and()
                .exceptionHandling()
                .and()
                .addFilter(providerFilter())
                .addFilterBefore(tokenFilter, JwtProviderFilter.class);
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
