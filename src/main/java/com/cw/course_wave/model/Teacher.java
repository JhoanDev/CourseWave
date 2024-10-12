package com.cw.course_wave.model;

public class Teacher extends User{

    public Teacher(int id, String name, String login, String email, String password, String role) {
        super(id, name, login, email, password, role);
    }

    public Teacher(String name, String login, String email, String password, String role) {
        super(name, login, email, password, role);
    }
}
