package com.cw.course_wave.controller;

import com.cw.course_wave.database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterController", urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String login = request.getParameter("login");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String role = request.getParameter("role");

        // Validações básicas de formulário
        if (name == null || login == null || email == null || password == null || confirmPassword == null) {
            request.setAttribute("error", "Todos os campos são obrigatórios.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "As senhas não coincidem.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        // Query para inserir os dados
        String sql = "INSERT INTO users (name, login, email, password, role) VALUES (?, ?, ?, ?, ?)";
        try {
            DatabaseConnection.executeQuery(sql, name, login, email, password, role);
            response.sendRedirect("index.jsp?success=true"); // retornando para a pagina de login
        } catch (SQLException e) {
            e.printStackTrace();
            // Define uma mensagem de erro e redireciona de volta para o formulário de registro
            request.setAttribute("error", "Erro ao registrar o usuário. Tente novamente.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}