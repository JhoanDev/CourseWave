package com.cw.course_wave.database;

import java.sql.*;
import java.util.logging.Logger;

public class DatabaseConnection {
    private static Connection instance;
    private static final Logger logger = Logger.getLogger(DatabaseConnection.class.getName());

    private static final String URL = "jdbc:mysql://localhost:3306/coursewave";
    private static final String USER = "****";
    private static final String PASSWORD = "****";

    private DatabaseConnection() {}

    // Obtém a conexão com o banco de dados
    public static Connection getInstance() throws SQLException {
        if (instance == null || instance.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                instance = DriverManager.getConnection(URL, USER, PASSWORD);
                logger.info("Conexão com o banco de dados estabelecida.");
            } catch (ClassNotFoundException e) {
                logger.severe("Driver JDBC não encontrado: " + e.getMessage());
                throw new SQLException("Driver JDBC não encontrado", e);
            } catch (SQLException e) {
                logger.severe("Erro ao conectar ao banco de dados: " + e.getMessage());
                throw new SQLException("Erro ao estabelecer conexão com o banco de dados", e);
            }
        }
        return instance;
    }

    // Método para preparar o PreparedStatement
    private static PreparedStatement prepareStatement(String sql, Object... params) throws SQLException {
        PreparedStatement statement = getInstance().prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            statement.setObject(i + 1, params[i]);
        }
        return statement;
    }

    // Método para consultas SELECT
    public static ResultSet executeSelect(String sql, Object... params) throws SQLException {
        PreparedStatement statement = prepareStatement(sql, params);
        return statement.executeQuery(); // Retorna o ResultSet da consulta
    }

    // Método para execução de queries de UPDATE/INSERT/DELETE
    public static void executeQuery(String sql, Object... params) throws SQLException {
        try (PreparedStatement statement = prepareStatement(sql, params)) {
            int rowsAffected = statement.executeUpdate();
            logger.info("Query executada com sucesso. Linhas afetadas: " + rowsAffected);
        } catch (SQLException e) {
            logger.severe("Erro ao executar a query: " + e.getMessage());
            throw new SQLException("Erro ao executar a query", e);
        }
    }

    public static int executeQueryWithGeneratedKey(String sql, Object... params) throws SQLException {
        try (PreparedStatement statement = prepareStatementWithGeneratedKey(sql, params)) {
            int rowsAffected = statement.executeUpdate();
            logger.info("Query executada com sucesso. Linhas afetadas: " + rowsAffected);

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); // Retorna o ID gerado
                } else {
                    throw new SQLException("Falha ao obter o ID gerado.");
                }
            }
        } catch (SQLException e) {
            logger.severe("Erro ao executar a query: " + e.getMessage());
            throw new SQLException("Erro ao executar a query", e);
        }
    }

    // Método para preparar o PreparedStatement com chave gerada
    private static PreparedStatement prepareStatementWithGeneratedKey(String sql, Object... params) throws SQLException {
        PreparedStatement statement = getInstance().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        for (int i = 0; i < params.length; i++) {
            statement.setObject(i + 1, params[i]);
        }
        return statement;
    }

}
