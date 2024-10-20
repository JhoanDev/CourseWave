package com.cw.course_wave.dao;

import com.cw.course_wave.util.Utils;

import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.factory.StudentFactory;
import com.cw.course_wave.factory.TeacherFactory;
import com.cw.course_wave.model.User;
import java.sql.SQLException;

public class UserDao {

    public void insertUser(User user) throws Exception {
        String password = Utils.generateMD5(user.getPassword());
        String sql = "INSERT INTO users (name, login, email, password, role) VALUES (?, ?, ?, ?, ?)";
        DatabaseConnection.executeQuery(sql, user.getName(), user.getLogin(), user.getEmail(), password, user.getRole());
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        var resultSet = DatabaseConnection.executeSelect(sql, id);

        if (resultSet.next()) {
            return createUserFromResultSet(resultSet);
        }

        resultSet.close();
        return null;
    }

    public User getUserByLoginAndPassword(String login, String password) throws Exception {
        String sql = "SELECT * FROM users WHERE login = ? AND password = ?";
        String pass = Utils.generateMD5(password);
        var resultSet = DatabaseConnection.executeSelect(sql, login, pass);

        if (resultSet.next()) {
            return createUserFromResultSet(resultSet);
        }

        resultSet.close();
        return null;
    }

    private User createUserFromResultSet(java.sql.ResultSet resultSet) throws SQLException {
        String role = resultSet.getString("role");
        User user;

        if ("student".equals(role)) {
            user = new StudentFactory().createUser(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("login"),
                    resultSet.getString("email"),
                    resultSet.getString("password")
            );
        } else {
            user = new TeacherFactory().createUser(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("login"),
                    resultSet.getString("email"),
                    resultSet.getString("password")
            );
        }
        return user;
    }


}
