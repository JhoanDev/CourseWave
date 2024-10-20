package com.cw.course_wave.controller;

import com.cw.course_wave.dao.CourseDao;
import com.cw.course_wave.dao.EnrollmentDao;
import com.cw.course_wave.model.Course;
import com.cw.course_wave.model.Enrollment;
import com.cw.course_wave.model.Link;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;


@WebServlet(name = "CourseController", urlPatterns = "/course")
public class CourseController extends HttpServlet {

    private final CourseDao courseDao = new CourseDao();
    private final EnrollmentDao enrollmentDao = new EnrollmentDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String method = request.getParameter("_method");
        String teacherIdParam = request.getParameter("teacherId");
        if ("DELETE".equals(method)) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            try {
                courseDao.deleteCourse(courseId);
                response.sendRedirect("teacher_dashboard.jsp?deleted=true");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        } else if ("PUT".equals(method)) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            Course course = getCourse(request);
            if (course == null) {
                request.getRequestDispatcher("edit_course.jsp").forward(request, response);
                return;
            }
            course.setId(courseId);
            course = addLinksToCourse(course, request);
            try {
                courseDao.updateCourse(course);
                response.sendRedirect("teacher_dashboard.jsp?updated=true");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Erro ao atualizar o curso: " + e.getMessage());
                request.getRequestDispatcher("edit_course.jsp").forward(request, response);
            }

        } else {
            Course course = getCourse(request);
            if (course == null) {
                request.getRequestDispatcher("register_course.jsp").forward(request, response);
                return;
            }

            course = addLinksToCourse(course, request);

            try {
                courseDao.insertCourse(course, Integer.parseInt(teacherIdParam));

                response.sendRedirect("teacher_dashboard.jsp?success=true"); // Redireciona após o cadastro

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Erro ao cadastrar o curso: " + e.getMessage());
                request.getRequestDispatcher("register_course.jsp").forward(request, response);
            }
        }
    }

    private Course getCourse(HttpServletRequest request) {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String hours = request.getParameter("hours");
        String teacherIdParam = request.getParameter("teacherId");

        if (title == null || description == null || hours == null || teacherIdParam == null) {
            request.setAttribute("error", "Todos os campos são obrigatórios.");
            return null;
        }

        int teacherId;
        try {
            teacherId = Integer.parseInt(teacherIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "ID do professor inválido.");
            return null;
        }

        return new Course(title, description, Integer.parseInt(hours), teacherId);
    }

    public Course addLinksToCourse(Course course, HttpServletRequest request) {
        String[] linkNames = request.getParameterValues("linkName[]");
        String[] linkTypes = request.getParameterValues("linkType[]");
        String[] linkUrls = request.getParameterValues("linkUrl[]");

        for (int i = 0; i < linkNames.length; i++) {
            if (linkNames[i] != null && !linkNames[i].isEmpty()) {
                course.addLink(new Link(linkNames[i], linkUrls[i], linkTypes[i]));
            }
        }
        return course;
    }
}

