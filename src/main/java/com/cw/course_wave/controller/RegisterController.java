package com.cw.course_wave.controller;

import com.cw.course_wave.database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "RegisterController", urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String login = request.getParameter("login");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String role = request.getParameter("role");

        if (name == null || login == null || email == null || password == null || confirmPassword == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dados inválidos.");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "As senhas não coincidem.");
            return;
        }

        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO users (name, login, email, password, role) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, login);
                statement.setString(3, email);
                statement.setString(4, password);
                statement.setString(5, role);
                statement.executeUpdate();
            }

            response.sendRedirect("index.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao registrar o usuário.");
        }
    }

}
