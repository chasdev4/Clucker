package com.clucker.cluckerserver.config;

import com.clucker.cluckerserver.security.filter.JwtProviderFilter;
import com.clucker.cluckerserver.security.filter.JwtTokenFilter;
import com.clucker.cluckerserver.security.service.UserDetailsServiceImpl;
import com.clucker.cluckerserver.security.util.JwtUtils;
import lombok.RequiredArgsConstructor;
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

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@RequiredArgsConstructor
public class WebSecurityConfiguration extends WebSecurityConfigurerAdapter {

    private final AppProperties appProperties;
    private final UserDetailsServiceImpl userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenFilter tokenFilter;
    private final JwtUtils jwtUtils;

    @Bean
    public JwtProviderFilter providerFilter() {
        return new JwtProviderFilter(jwtUtils);
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
        allowPutRequests(http);

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

    private void allowPutRequests(HttpSecurity http) throws Exception {
        if (appProperties.getAllowAllPut() == null ||
                appProperties.getAllowAllPut().length == 0)
            return;

        http.authorizeRequests()
                .antMatchers(HttpMethod.PUT, appProperties.getAllowAllPut())
                .permitAll();
    }
}
