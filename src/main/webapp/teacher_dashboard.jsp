<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cw.course_wave.model.Course" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.cw.course_wave.model.User" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel do Professor - Course Wave</title>
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
            padding: 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer; /* Adiciona um cursor pointer */
            transition: background-color 0.3s; /* Adiciona uma transição suave */
        }
        .course-list li:hover {
            background-color: #f0f0f0; /* Altera a cor de fundo ao passar o mouse */
        }
        .btn {
            background-color: #007bff; /* Altera a cor do botão */
            color: white;
            padding: 10px 15px; /* Adiciona um pouco mais de padding */
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
            border: none; /* Remove a borda padrão */
            transition: background-color 0.3s; /* Adiciona uma transição suave */
        }
        .btn:hover {
            background-color: #0056b3; /* Cor do botão ao passar o mouse */
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
    int professorId = user.getId(); // ID do professor

    // Recuperando a lista de cursos do controlador
    ArrayList<Course> courses = (ArrayList<Course>) request.getAttribute("courses");
%>

<div class="header">
    <h1>Bem-vindo, Professor <%= nome %>!</h1>
</div>

<div class="container">
    <!-- Perfil -->
    <div class="section">
        <h2>Perfil</h2>
        <p>Nome: <%= nome %></p>
        <p>Email: <%= email %></p>
    </div>

    <!-- Cursos Cadastrados -->
    <div class="section">
        <h2>Seus Cursos</h2>
        <form action="course" method="GET">
            <button type="submit" class="btn">Carregar Cursos</button>
        </form>
        <ul class="course-list">
            <%
                if (courses != null && !courses.isEmpty()) {
                    for (Course course : courses) {
            %>
            <li onclick="location.href='courseDetails.jsp?courseId=<%= course.getId() %>';">
                <strong>Título:</strong> <%= course.getTitle() %> <br>
                <strong>Descrição:</strong> <%= course.getDescription() %> <br>
                <strong>Carga Horária:</strong> <%= course.getHours() %> horas
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

    <div class="section">
        <h2>Cadastrar Novo Curso</h2>
        <a href="register_course.jsp?professorId=<%= professorId %>" class="btn">Cadastrar Curso</a>
    </div>
</div>

</body>
</html>
