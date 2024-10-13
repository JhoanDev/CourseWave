package com.cw.course_wave.factory;

import com.cw.course_wave.model.User;

public interface UserFactory {
    User createUser(String name, String login, String email, String password);

    User createUser(int id, String name, String login, String email, String password);
}
