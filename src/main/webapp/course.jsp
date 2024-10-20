<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cw.course_wave.model.Course" %>
<%@ page import="com.cw.course_wave.model.Link" %>
<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.cw.course_wave.dao.CourseDao" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Curso - Course Wave</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            line-height: 1.6;
            color: #333;
        }

        .header {
            background-color: #007bff;
            color: white;
            padding: 20px;
            text-align: left;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .header h1 {
            margin: 0;
            display: inline;
        }

        .btn-back {
            background-color: #6c757d;
            color: white;
            padding: 15px 30px; /* Aumentando o padding para aumentar o tamanho do botão */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 16px; /* Aumentando o tamanho da fonte */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Adicionando sombra ao botão */
        }

        .btn-back:hover {
            background-color: #5a6268;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
        }

        .section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .section h2 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .link-list {
            list-style: none;
            padding: 0;
        }

        .link-list li {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            display: flex;
            align-items: center;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin-bottom: 10px;
            transition: background-color 0.3s ease;
        }

        .link-list li:hover {
            background-color: #e9ecef;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .link-list li i {
            font-size: 24px;
            margin-right: 15px;
        }

        .link-list li a {
            font-size: 18px;
            color: #007bff;
            text-decoration: none;
            margin-left: 10px;
            flex-grow: 1;
        }

        .link-list li a:hover {
            text-decoration: underline;
        }

        .link-list li.pdf i {
            color: #d9534f;
        }

        .link-list li.drive i {
            color: #4285f4;
        }

        .link-list li.video i {
            color: #f4b400;
        }

        .link-list li.image i {
            color: #5cb85c;
        }

        .btn {
            background-color: #28a745;
            color: white;
            padding: 12px 20px; /* Aumentando o padding dos botões de ação */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 10px;
            font-size: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }

        .btn:hover {
            background-color: #218838;
        }

        .btn-remove {
            background-color: #dc3545;
        }

        .btn-remove:hover {
            background-color: #c82333;
        }

        /* Responsividade */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .link-list li a {
                font-size: 16px;
            }

            .btn, .btn-back {
                width: 100%; /* Tornando os botões ocuparem 100% em telas menores */
                margin: 5px 0; /* Espaçamento entre os botões */
            }
        }
    </style>
</head>

<body>

<%
    String courseIdParam = request.getParameter("courseId");
    int courseId = 0;

    try {
        courseId = Integer.parseInt(courseIdParam);
    } catch (NumberFormatException e) {
        out.println("<h2>ID de curso inválido!</h2>");
        return;
    }

    CourseDao courseDao = new CourseDao();
    Course course = null;
    try {
        course = courseDao.getCourseById(courseId);
    } catch (SQLException e) {
        out.println("<h2>Erro ao carregar os detalhes do curso!</h2>");
        e.printStackTrace();
        return;
    }

    if (course == null) {
        out.println("<h2>Curso não encontrado!</h2>");
        return;
    }

    List<Link> links = course.getLinks();
    Integer userTypeNumber = (session != null && session.getAttribute("usertype") != null)
            ? (Integer) session.getAttribute("usertype")
            : 0;
%>

<div class="header">
    <h1>Detalhes do Curso: <%= course.getTitle() %></h1>
    <button class="btn-back" onclick="location.href='<%= userTypeNumber == 1 ? "teacher_dashboard.jsp" : "student_dashboard.jsp" %>';">Voltar</button>
</div>

<div class="container">
    <div class="section">
        <h2>Informações do Curso</h2>
        <p><strong>Título:</strong> <%= course.getTitle() %></p>
        <p><strong>Descrição:</strong> <%= course.getDescription() %></p>
        <p><strong>Professor:</strong> <%= courseDao.getProfessorNameByCourseId(course.getId()) %></p>
        <p><strong>Carga Horária:</strong> <%= course.getHours() %> horas</p>

        <% if (userTypeNumber == 1) { %>
        <a href="edit_course.jsp?courseId=<%= course.getId() %>" class="btn">Editar Curso</a>
        <form action="course" method="post" style="display:inline;">
            <input type="hidden" name="courseId" value="<%= course.getId() %>">
            <input type="hidden" name="_method" value="DELETE">
            <button type="submit" class="btn btn-remove" onclick="return confirm('Tem certeza que deseja remover este curso?');">Remover Curso</button>
        </form>
        <% } else { %>
        <button class="btn" onclick="location.href='completeEnrollment?enrollmentId=<%= courseId %>';">Concluir Curso</button>
        <button class="btn btn-remove" onclick="location.href='deleteEnrollment?enrollmentId=<%= courseId %>';">Desmatricular</button>
        <% } %>
    </div>

    <div class="section">
        <h2>Conteúdo do Curso</h2>
        <ul class="link-list">
            <%
                if (links != null && !links.isEmpty()) {
                    for (Link link : links) {
                        String linkTypeClass = "";
                        String icon = "";
                        switch (link.getType()) {
                            case "pdf":
                                linkTypeClass = "pdf";
                                icon = "<i class='fas fa-file-pdf'></i>";
                                break;
                            case "drive":
                                linkTypeClass = "drive";
                                icon = "<i class='fas fa-cloud'></i>";
                                break;
                            case "video":
                                linkTypeClass = "video";
                                icon = "<i class='fas fa-video'></i>";
                                break;
                            case "image":
                                linkTypeClass = "image";
                                icon = "<i class='fas fa-image'></i>";
                                break;
                            default:
                                linkTypeClass = "";
                                icon = "<i class='fas fa-link'></i>";
                        }
            %>
            <li class="<%= linkTypeClass %>">
                <%= icon %> <strong><%= link.getName() %></strong>:
                <a href="<%= link.getUrl().startsWith("http://") || link.getUrl().startsWith("https://") ? link.getUrl() : "https://" + link.getUrl() %>" target="_blank">
                    <%= link.getUrl() != null ? link.getUrl() : link.getName() %>
                </a>
            </li>
            <%
                }
            } else {
            %>
            <li>Não há links disponíveis para este curso.</li>
            <%
                }
            %>
        </ul>
    </div>
</div>

</body>
</html>
