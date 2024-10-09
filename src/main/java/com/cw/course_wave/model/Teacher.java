package com.cw.course_wave.model;

public class Teacher extends User{

    public Teacher(String name, String email, String password) {
        super(name, email, password, "teacher");
    }

    public Teacher(int id, String name, String email, String password) {
        super(id, name, email, password, "teacher");
    }

}
