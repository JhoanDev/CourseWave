package com.cw.course_wave.controller;

import com.cw.course_wave.database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "CourseController", urlPatterns = "/cadastrarCurso")
public class CourseController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recuperando parâmetros do formulário
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String hours = request.getParameter("hours");
        String teacherIdParam = request.getParameter("teacherId");

        // Validação básica
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

        try {
            // Inserindo o curso e obtendo o ID gerado
            String courseSql = "INSERT INTO courses (title, description, hours, teacher_id) VALUES (?, ?, ?, ?)";
            int courseId = DatabaseConnection.executeQueryWithGeneratedKey(courseSql, title, description, Integer.parseInt(hours), teacherId);

            // Inserindo links, se houver
            String[] linkNames = request.getParameterValues("linkName[]");
            String[] linkTypes = request.getParameterValues("linkType[]");
            String[] linkUrls = request.getParameterValues("linkUrl[]");

            if (linkNames != null) {
                String linkSql = "INSERT INTO links (course_id, name, type, url) VALUES (?, ?, ?, ?)";
                for (int i = 0; i < linkNames.length; i++) {
                    if (linkNames[i] != null && !linkNames[i].isEmpty()) {
                        DatabaseConnection.executeQuery(linkSql, courseId, linkNames[i], linkTypes[i], linkUrls[i]);
                    }
                }
            }

            response.sendRedirect("teacher_dashboard.jsp?success=true"); // Redireciona após o cadastro
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao cadastrar o curso: " + e.getMessage());
            request.getRequestDispatcher("register_course.jsp").forward(request, response);
        }
    }
}
