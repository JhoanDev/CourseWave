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
    <title>Painel do Professor - Course Wave</title>
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
            align-items: center; /* Alinha os botões na mesma altura */
        }
        .container {
            max-width: 900px;
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
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
            font-size: 1rem;
            line-height: 1.5; /* Ajusta a linha para centralizar texto */
            display: flex; /* Garante que o texto fique centralizado */
            align-items: center; /* Centraliza verticalmente */
            justify-content: center; /* Centraliza horizontalmente */
        }
        .btn-cadastrar {
            background-color: #28a745; /* Verde para cadastrar */
        }
        .btn-cadastrar:hover {
            background-color: #218838; /* Verde escuro ao passar o mouse */
        }
        .btn-logout {
            background-color: #dc3545; /* Vermelho para logout */
        }
        .btn-logout:hover {
            background-color: #c82333; /* Vermelho escuro ao passar o mouse */
        }
        .btn-details {
            background-color: #007bff; /* Azul para detalhes */
        }
        .btn-details:hover {
            background-color: #0056b3; /* Azul escuro ao passar o mouse */
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
    User user = (User) session.getAttribute("user");
    session.setAttribute("usertype", 1);
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String nome = user.getName();
    String email = user.getEmail();
    int professorId = user.getId();
    CourseDao courseDao = new CourseDao();

    ArrayList<Course> courses = null;
    try {
        courses = courseDao.getCoursesByTeacherId(professorId);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>

<div class="header">
    <h1>Bem-vindo, Professor <%= nome %>!</h1>
    <div class="btn-group">
        <a href="register_course.jsp?professorId=<%= professorId %>" class="btn btn-cadastrar">Cadastrar Novo Curso</a>
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

    <!-- Cursos Cadastrados -->
    <div class="section">
        <h2>Seus Cursos</h2>
        <ul class="course-list">
            <%
                if (courses != null && !courses.isEmpty()) {
                    for (Course course : courses) {
            %>
            <li onclick="location.href='course.jsp?courseId=<%= course.getId() %>';">
                <div class="course-info">
                    <strong>Título:</strong> <%= course.getTitle() %><br>
                    <strong>Descrição:</strong> <%= course.getDescription() %><br>
                    <span class="course-hours"><strong>Carga Horária:</strong> <%= course.getHours() %> horas</span>
                </div>
                <button class="btn btn-details">Detalhes</button> <!-- Botão detalhes em azul -->
            </li>
            <%
                }
            } else {
            %>
            <li>Você ainda não cadastrou nenhum curso.</li>
            <%
                }
            %>
        </ul>
    </div>
</div>

</body>
</html>
