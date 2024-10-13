<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.cw.course_wave.model.User" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
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
        }
        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #218838;
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
%>

<div class="header">
    <h1>Bem-vindo, Professor!</h1>
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
        <ul class="course-list">
            <li>Curso 1 - Introdução à Programação</li>
            <li>Curso 2 - Estruturas de Dados</li>
            <li>Curso 3 - Desenvolvimento Web</li>
        </ul>
    </div>

    <div class="section">
        <h2>Cadastrar Novo Curso</h2>
        <a href="register_course.jsp?professorId=<%= professorId %>" class="btn">Cadastrar Curso</a>
    </div>
</div>

</body>
</html>
