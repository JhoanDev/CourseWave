package com.cw.course_wave.factory;

import com.cw.course_wave.model.Student;
import com.cw.course_wave.model.User;

public class StudentFactory implements UserFactory {
    @Override
    public User createUser(String name, String login, String email, String password) {
        return new Student(name, login, email, password);
    }

    @Override
    public User createUser(int id, String name, String login, String email, String password) {
        return new Student(id, name, login, email, password);
    }
}
