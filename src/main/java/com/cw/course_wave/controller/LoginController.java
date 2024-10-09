package com.cw.course_wave.controller;

import com.cw.course_wave.database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String login = request.getParameter("login");
        String password = request.getParameter("password");

        if (login == null || password == null) {
            request.setAttribute("error", "Login e senha são obrigatórios.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        try {
            String sql = "SELECT role FROM users WHERE login = ? AND password = ?";
            ResultSet resultSet = DatabaseConnection.executeSelect(sql, login, password);

            if (resultSet.next()) {
                String role = resultSet.getString("role");


                HttpSession session = request.getSession();
                session.setAttribute("login", login);
                session.setAttribute("role", role);

                if ("teacher".equals(role)) {
                    response.sendRedirect("teacher_dashboard.jsp");
                } else if ("student".equals(role)) {
                    response.sendRedirect("student_dasboard.jsp");
                }
            } else {
                // Caso as credenciais estejam erradas
                request.setAttribute("error", "Login ou senha inválidos.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao realizar o login. Tente novamente.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
