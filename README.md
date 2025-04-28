# springboot-security-database-jdbc #

The `spring-boot-starter-security` dependency enables the authentication and authorization in all end-points.

The configurations override the default user creation; see `springboot-security-default`; and the default `SecurityFilterChain`.

The user credentials and stored into database; instead of properties or configuration.

The JDBC option uses that the pre-defined database tables:
- `users` - contains the user credentials
- `authorities` - contains the user roles

The used database in this case is MySLQL, but it can be any database that is supported by Spring Boot.

The following properties are needed for accessing the database; hard-coded and human readable credentials should be used on development only.

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/pikecape
    username: root
    password: root
```

The `src/resources/sql/scripts.sql` file contains the SQL commands to create the tables and insert the default user credentials.

The configuration is pretty similar when the user credentials are stored into memory; see `springboot-security-basic-in-memory`.

```java
@Configuration
public class WebSecurityConfiguration {
  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
    httpSecurity.authorizeHttpRequests(requests -> requests
        .requestMatchers("/api/duey").hasRole("USER")
        .requestMatchers("/api/huey").authenticated()
        .requestMatchers("/api/luey").permitAll());

    httpSecurity.formLogin(Customizer.withDefaults());
    httpSecurity.httpBasic(Customizer.withDefaults());

    return httpSecurity.build();
  }

  @Bean
  public UserDetailsService userDetailsService(DataSource dataSource) {
    return new JdbcUserDetailsManager(dataSource);
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return PasswordEncoderFactories.createDelegatingPasswordEncoder();
  }
}
```

## Security Filter Chain ##

The `SecurityFilterChain` is a bean that configures security settings for each end-point:

- `/api/duey` is accessible only for users with ROLE_USER role
- `/api/huey` is accessible for authenticated users
- `/api/luey` is accessible for all users

- The `httpSecurity.formLogin()` and `httpSecurity.httpBasic()` methods enable form-based and basic authentication.

## User Details Service ##

The `UserDetailsService` is a bean that provides user details from the database. It uses the `JdbcUserDetailsManager` class to manage user credentials.

## Password Encoder ##

The `PasswordEncoder` is a bean that creates a password encoder that uses the bcrypt algorithm.

The bcrypt is basically the default password encoder in Spring Security.

The password can be encoded in https://bcrypt-generator.com/ for testing purposes.
