package com.cw.course_wave.database;

import java.sql.*;
import java.util.logging.Logger;

public class DatabaseConnection {
    private static Connection instance;
    private static final Logger logger = Logger.getLogger(DatabaseConnection.class.getName());

    private static final String URL = "jdbc:mysql://localhost:3306/coursewave";
    private static final String USER = "jhoan";
    private static final String PASSWORD = "13062004";

    private DatabaseConnection() {}

    public static Connection getInstance() throws SQLException {
        try {
            if (instance == null || instance.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                instance = DriverManager.getConnection(URL, USER, PASSWORD);
                logger.info("Conexão com o banco de dados estabelecida.");
            }
        } catch (ClassNotFoundException e) {
            logger.severe("Driver JDBC não encontrado: " + e.getMessage());
            throw new SQLException("Driver JDBC não encontrado", e);
        } catch (SQLException e) {
            logger.severe("Erro ao conectar ao banco de dados: " + e.getMessage());
            throw new SQLException("Erro ao estabelecer conexão com o banco de dados", e);
        }
        return instance;
    }

    // Método para consultas SELECT
    public static ResultSet executeSelect(String sql, Object... params) throws SQLException {
        Connection connection = getInstance();
        PreparedStatement statement = connection.prepareStatement(sql);

        for (int i = 0; i < params.length; i++) {
            statement.setObject(i + 1, params[i]);
        }

        return statement.executeQuery(); // Retorna o ResultSet da consulta
    }

    // Método para execução de queries de UPDATE/INSERT/DELETE
    public static void executeQuery(String sql, Object... params) throws SQLException {
        try (Connection connection = getInstance();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            for (int i = 0; i < params.length; i++) {
                statement.setObject(i + 1, params[i]);
            }

            // Executando a query
            int rowsAffected = statement.executeUpdate();
            logger.info("Query executada com sucesso. Linhas afetadas: " + rowsAffected);

        } catch (SQLException e) {
            logger.severe("Erro ao executar a query: " + e.getMessage());
            throw new SQLException("Erro ao executar a query", e);
        }
    }
}
