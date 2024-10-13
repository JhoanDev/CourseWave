package com.cw.course_wave.controller;

import com.cw.course_wave.dao.UserDao;
import com.cw.course_wave.database.DatabaseConnection;
import com.cw.course_wave.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterController", urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    private final UserDao userDao = new UserDao();

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

        User user = new User(name, login, email, password, role);
        try {
            userDao.insertUser(user);
            response.sendRedirect("index.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao cadastrar usuário. Tente novamente.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }

    }
}