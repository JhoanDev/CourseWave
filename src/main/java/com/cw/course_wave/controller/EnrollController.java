package com.cw.course_wave.controller;

import com.cw.course_wave.dao.EnrollmentDao;
import com.cw.course_wave.model.Enrollment;
import com.cw.course_wave.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "EnrollController", urlPatterns = "/enroll")
public class EnrollController extends HttpServlet {

    private final EnrollmentDao enrollmentDao = new EnrollmentDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        // Verifica se o usuário está logado
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String courseIdParam = request.getParameter("courseId");
        if (courseIdParam == null || !courseIdParam.matches("\\d+")) {
            request.setAttribute("error", "ID do curso inválido.");
            request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
            return;
        }

        int courseId = Integer.parseInt(courseIdParam);
        Enrollment enrollment = new Enrollment(user.getId(), courseId, new Timestamp(System.currentTimeMillis()), false);

        try {
            // Insere a matrícula no banco de dados
            enrollmentDao.insertEnrollment(enrollment);
            response.sendRedirect("student_dashboard.jsp?success=true"); // Redireciona de volta com sucesso
        } catch (Exception e) {
            // Log de erro aqui (utilizar um logger)
            e.printStackTrace();
            request.setAttribute("error", "Erro ao matricular-se no curso. Tente novamente.");
            request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
        }
    }
}