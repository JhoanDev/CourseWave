package com.cw.course_wave.model;

public interface User {
    String getRole();

    String getName();

    String getLogin();

    String getEmail();

    String getPassword();

    int getId();

    void setName(String name);

    void setLogin(String login);

    void setEmail(String email);

    void setPassword(String password);

    void setId(int id);

}
