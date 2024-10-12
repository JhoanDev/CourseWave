package com.cw.course_wave.dao;


import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.model.User;

public class UserDao {

    public void insertUser(User user) throws Exception {
        String sql = "INSERT INTO users (name, login, email, password, role) VALUES (?, ?, ?, ?, ?)";
        DatabaseConnection.executeQuery(sql, user.getName(), user.getLogin(), user.getEmail(), user.getPassword(), user.getRole());
    }

    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserByLoginAndPassword(String login, String password) {
        String sql = "SELECT * FROM users WHERE login = ? AND password = ?";
        try {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
