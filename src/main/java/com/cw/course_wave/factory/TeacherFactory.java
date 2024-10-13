package com.cw.course_wave.factory;

import com.cw.course_wave.model.Teacher;
import com.cw.course_wave.model.User;

public class TeacherFactory implements UserFactory {
    @Override
    public User createUser(String name, String login, String email, String password) {
        return new Teacher(name, login, email, password);
    }

    @Override
    public User createUser(int id, String name, String login, String email, String password) {
        return new Teacher(id, name, login, email, password);
    }
}
