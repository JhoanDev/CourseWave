package com.cw.course_wave.dao;


import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.model.User;

import java.sql.SQLException;

public class UserDao {

    public void insertUser(User user) throws SQLException {
        String sql = "INSERT INTO users (name, login, email, password, role) VALUES (?, ?, ?, ?, ?)";
        DatabaseConnection.executeQuery(sql, user.getName(), user.getLogin(), user.getEmail(), user.getPassword(), user.getRole());
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, id);

        if (resultSet.next()) {
            return new User(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("login"),
                    resultSet.getString("email"),
                    resultSet.getString("password"),
                    resultSet.getString("role")
            );
        }

        resultSet.close();
        return null;
    }

    public User getUserByLoginAndPassword(String login, String password) throws SQLException {
        String sql = "SELECT * FROM users WHERE login = ? AND password = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, login, password);

        if (resultSet.next()) {
            return new User(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("login"),
                    resultSet.getString("email"),
                    resultSet.getString("password"),
                    resultSet.getString("role")
            );
        }

        resultSet.close();
        return null;
    }
}
