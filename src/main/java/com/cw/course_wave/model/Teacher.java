package com.cw.course_wave.model;

public class Teacher implements User {
    private String name;
    private String login;
    private String email;
    private String password;
    private int id;

    public Teacher(int id, String name, String login, String email, String password) {
        this.name = name;
        this.login = login;
        this.email = email;
        this.password = password;
        this.id = id;
    }

    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public void setLogin(String login) {
        this.login = login;
    }

    @Override
    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }

    public Teacher(String name, String login, String email, String password) {
        this.name = name;
        this.login = login;
        this.email = email;
        this.password = password;
    }

    @Override
    public String getRole() {
        return "teacher";
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getLogin() {
        return login;
    }

    @Override
    public String getEmail() {
        return email;
    }

    @Override
    public String getPassword() {
        return password;
    }
}
