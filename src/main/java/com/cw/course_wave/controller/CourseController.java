package com.cw.course_wave.controller;

import com.cw.course_wave.dao.CourseDao;
import com.cw.course_wave.model.Course;
import com.cw.course_wave.model.Link;
import com.cw.course_wave.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CourseController", urlPatterns = "/course")
public class CourseController extends HttpServlet {

    private final CourseDao courseDao = new CourseDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String method = request.getParameter("_method");
        if ("DELETE".equals(method)) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            try {
                courseDao.deleteCourse(courseId);
                response.sendRedirect("teacher_dashboard.jsp?deleted=true");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String hours = request.getParameter("hours");
            String teacherIdParam = request.getParameter("teacherId");

            if (title == null || description == null || hours == null || teacherIdParam == null) {
                request.setAttribute("error", "Todos os campos são obrigatórios.");
                request.getRequestDispatcher("register_course.jsp").forward(request, response);
                return;
            }

            int teacherId;
            try {
                teacherId = Integer.parseInt(teacherIdParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "ID do professor inválido.");
                request.getRequestDispatcher("register_course.jsp").forward(request, response);
                return;
            }

            Course course = new Course(title, description, Integer.parseInt(hours), teacherId);

            String[] linkNames = request.getParameterValues("linkName[]");
            String[] linkTypes = request.getParameterValues("linkType[]");
            String[] linkUrls = request.getParameterValues("linkUrl[]");

            for (int i = 0; i < linkNames.length; i++) {
                if (linkNames[i] != null && !linkNames[i].isEmpty()) {
                    course.addLink(new Link(linkNames[i], linkUrls[i], linkTypes[i]));
                }
            }

            try {
                courseDao.insertCourse(course);
                response.sendRedirect("teacher_dashboard.jsp?success=true"); // Redireciona após o cadastro
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Erro ao cadastrar o curso: " + e.getMessage());
                request.getRequestDispatcher("register_course.jsp").forward(request, response);
            }
        }
    }
}

