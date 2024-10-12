package com.cw.course_wave.controller;

import com.cw.course_wave.database.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

        Connection connection = null;
        PreparedStatement courseStatement = null;
        PreparedStatement linkStatement = null;

        try {
            connection = DatabaseConnection.getInstance();

            // Inserindo o curso
            String courseSql = "INSERT INTO courses (title, description, hours, teacher_id) VALUES (?, ?, ?, ?)";
            courseStatement = connection.prepareStatement(courseSql, PreparedStatement.RETURN_GENERATED_KEYS);
            courseStatement.setString(1, title);
            courseStatement.setString(2, description);
            courseStatement.setInt(3, Integer.parseInt(hours));
            courseStatement.setInt(4, teacherId);
            courseStatement.executeUpdate();

            // Obtendo o ID do curso inserido
            int courseId = courseStatement.getGeneratedKeys().getInt(1);

            // Inserindo links, se houver
            String[] linkNames = request.getParameterValues("linkName[]");
            String[] linkTypes = request.getParameterValues("linkType[]");
            String[] linkUrls = request.getParameterValues("linkUrl[]");

            if (linkNames != null) {
                String linkSql = "INSERT INTO course_links (course_id, name, type, url) VALUES (?, ?, ?, ?)";
                linkStatement = connection.prepareStatement(linkSql);

                for (int i = 0; i < linkNames.length; i++) {
                    linkStatement.setInt(1, courseId);
                    linkStatement.setString(2, linkNames[i]);
                    linkStatement.setString(3, linkTypes[i]);
                    linkStatement.setString(4, linkUrls[i]);
                    linkStatement.addBatch();
                }
                linkStatement.executeBatch(); // Executando a inserção em lote
            }

            // Redireciona para uma página de sucesso
            response.sendRedirect("success.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Erro ao cadastrar o curso. Tente novamente.");
            request.getRequestDispatcher("register_course.jsp").forward(request, response);
        } finally {
            // Fechando recursos
            try {
                if (linkStatement != null) linkStatement.close();
                if (courseStatement != null) courseStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
