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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"teacher".equals(user.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        int teacherId = user.getId(); // ID do professor logado

        try {
            ArrayList<Course> courses = courseDao.getCoursesByTeacherId(teacherId);

            request.setAttribute("courses", courses);
            request.getRequestDispatcher("teacher_dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao buscar os cursos: " + e.getMessage());
            request.getRequestDispatcher("teacher_dashboard.jsp").forward(request, response);
        }
    }
}

