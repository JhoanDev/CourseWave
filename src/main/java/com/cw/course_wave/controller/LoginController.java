package com.cw.course_wave.controller;

import com.cw.course_wave.dao.UserDao;
import com.cw.course_wave.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    private final UserDao userDao = new UserDao();

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
            User user = userDao.getUserByLoginAndPassword(login, password);

            if (user != null) {
                request.getSession().setAttribute("user", user);

                if (Objects.equals(user.getRole(), "teacher")) {
                    response.sendRedirect("teacher_dashboard.jsp");
                } else if (Objects.equals(user.getRole(), "student")) {
                    response.sendRedirect("student_dashboard.jsp");
                }
            } else {
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
