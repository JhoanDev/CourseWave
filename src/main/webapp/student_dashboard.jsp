<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cw.course_wave.model.Course" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cw.course_wave.model.User" %>
<%@ page import="com.cw.course_wave.dao.CourseDao" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Estudante - Course Wave</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .header h1 {
            margin: 0;
            font-size: 1.8rem;
        }
        .btn-group {
            display: flex;
            gap: 10px;
        }
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }
        .section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s;
        }
        .section:hover {
            transform: translateY(-5px);
        }
        .section h2 {
            color: #333;
            font-size: 1.5rem;
            margin-bottom: 15px;
        }
        .section p {
            color: #666;
            font-size: 1rem;
            margin-bottom: 10px;
        }
        .course-list {
            list-style: none;
            padding: 0;
        }
        .course-list li {
            display: flex;
            justify-content: space-between;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            margin-bottom: 10px;
            background-color: #fafafa;
            transition: background-color 0.3s ease;
            align-items: center;
        }
        .course-list li:hover {
            background-color: #f0f8ff;
        }
        .course-info {
            flex-grow: 1;
            margin-right: 20px;
        }
        .course-hours {
            font-weight: bold;
            color: #333;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 12px 20px; /* Aumenta o padding para mais espaço interno */
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
            font-size: 1rem;
            height: 50px; /* Aumenta a altura do botão */
            min-width: 120px; /* Define uma largura mínima para o botão */
            display: flex; /* Usado para centralizar o conteúdo do botão */
            align-items: center; /* Centraliza verticalmente o conteúdo */
            justify-content: center; /* Centraliza horizontalmente o conteúdo */
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-logout {
            background-color: #dc3545;
            padding: 12px 20px; /* Consistente com o botão de login */
            border-radius: 5px; /* Consistente com o estilo geral */
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 1rem;
            height: 50px; /* Define uma altura fixa para os botões */
        }
        .btn-logout:hover {
            background-color: #c82333;
        }
        .profile-info p {
            font-size: 1rem;
            color: #333;
        }
        .profile-info p span {
            font-weight: bold;
            color: #007bff;
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
    <div class="btn-group">
        <form action="logout" method="post" style="margin: 0;">
            <button type="submit" class="btn btn-logout">Logout</button>
        </form>
    </div>
</div>

<div class="container">
    <!-- Perfil -->
    <div class="section profile-info">
        <h2>Perfil</h2>
        <p>Nome: <span><%= nome %></span></p>
        <p>Email: <span><%= email %></span></p>
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
                    <strong>Professor:</strong> <%= courseDao.getProfessorNameByCourseId(course.getId()) %> <br>
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
                    <strong>Professor:</strong> <%= courseDao.getProfessorNameByCourseId(course.getId()) %> <br>
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
