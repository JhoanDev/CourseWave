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



@WebServlet("/completeEnrollment")
public class CompleteEnrollmentController extends HttpServlet {

    private final EnrollmentDao enrollmentDao = new EnrollmentDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int enrollmentId = Integer.parseInt(request.getParameter("enrollmentId"));

        try {
            Enrollment enrollment = enrollmentDao.getEnrollment(user.getId(), enrollmentId);
            if (enrollment != null) {
                enrollment.setCompleted(true); // Marca a matrícula como concluída
                enrollmentDao.updateEnrollment(enrollment); // Atualiza a matrícula no banco de dados
                response.sendRedirect("student_dashboard.jsp?success=true"); // Redireciona de volta com sucesso
            } else {
                request.setAttribute("error", "Matrícula não encontrada.");
                request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao concluir o curso. Tente novamente.");
            request.getRequestDispatcher("student_dashboard.jsp").forward(request, response);
        }
    }
}
