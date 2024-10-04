package com.cw.course_wave.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/coursewave";
    private static final String USER = "jhoan";
    private static final String PASSWORD = "13062004";

    // Método para inicializar e retornar a conexão com o banco de dados
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
