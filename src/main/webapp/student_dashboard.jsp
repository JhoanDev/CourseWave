<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cw.course_wave.model.Course" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cw.course_wave.model.User" %>
<%@ page import="com.cw.course_wave.dao.CourseDao" %>
<%@ page import="com.cw.course_wave.dao.EnrollmentDao" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Estudante - Course Wave</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 15px 20px;
            text-align: center;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            padding: 20px;
        }
        .section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .section h2 {
            color: #333;
        }
        .section p {
            color: #555;
        }
        .course-list {
            list-style: none;
            padding: 0;
        }
        .course-list li {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
            transition: background-color 0.3s;
            align-items: center;
        }
        .course-list li:hover {
            background-color: #f0f0f0;
        }
        .course-info {
            flex-grow: 1;
            margin-right: 20px;
        }
        .course-hours {
            font-weight: bold;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%
    // Recuperando os dados do usuário da sessão
    User user = (User) session.getAttribute("user");

    // Verificando se o usuário está logado
    if (user == null) {
        response.sendRedirect("index.jsp"); // Redireciona para a página de login se não houver usuário
        return;
    }

    String nome = user.getName();
    String email = user.getEmail();
    int estudanteId = user.getId(); // ID do estudante

    // Recuperando a lista de cursos matriculados e cursos disponíveis
    CourseDao courseDao = new CourseDao();

    ArrayList<Course> enrolledCourses = null;
    ArrayList<Course> availableCourses = null;

    try {
        enrolledCourses = courseDao.getCoursesByStudentId(estudanteId);
        availableCourses = courseDao.getAvailableCoursesForStudent(estudanteId);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>

<div class="header">
    <h1>Bem-vindo, <%= nome %>!</h1>
</div>

<div class="container">
    <!-- Perfil -->
    <div class="section">
        <h2>Perfil</h2>
        <p>Nome: <%= nome %></p>
        <p>Email: <%= email %></p>
    </div>

    <!-- Cursos Matriculados -->
    <div class="section">
        <h2>Cursos Matriculados</h2>
        <ul class="course-list">
            <%
                if (enrolledCourses != null && !enrolledCourses.isEmpty()) {
                    for (Course course : enrolledCourses) {
            %>
            <li onclick="location.href='course.jsp?courseId=<%= course.getId() %>'; ">
                <div class="course-info">
                    <strong>Título:</strong> <%= course.getTitle() %> <br>
                    <strong>Descrição:</strong> <%= course.getDescription() %> <br>
                    <span class="course-hours"><strong>Carga Horária:</strong> <%= course.getHours() %> horas</span>
                </div>
                <button class="btn">Ver Curso</button>
            </li>
            <%
                }
            } else {
            %>
            <li>Você ainda não está matriculado em nenhum curso.</li>
            <%
                }
            %>
        </ul>
    </div>

    <!-- Cursos Disponíveis para Matrícula -->
    <div class="section">
        <h2>Cursos Disponíveis</h2>
        <ul class="course-list">
            <%
                if (availableCourses != null && !availableCourses.isEmpty()) {
                    for (Course course : availableCourses) {
            %>
            <li onclick="location.href='enroll?courseId=<%= course.getId() %>'; ">
                <div class="course-info">
                    <strong>Título:</strong> <%= course.getTitle() %> <br>
                    <strong>Descrição:</strong> <%= course.getDescription() %> <br>
                    <span class="course-hours"><strong>Carga Horária:</strong> <%= course.getHours() %> horas</span>
                </div>
                <button class="btn">Matricular-se</button>
            </li>
            <%
                }
            } else {
            %>
            <li>Não há cursos disponíveis para matrícula no momento.</li>
            <%
                }
            %>
        </ul>
    </div>
</div>

</body>
</html>
