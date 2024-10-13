<%@ page import="com.cw.course_wave.model.Link" %>
<%@ page import="com.cw.course_wave.model.Course" %>
<%@ page import="com.cw.course_wave.dao.CourseDao" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.cw.course_wave.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Curso - Course Wave</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 50px;
            margin: 0;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            resize: vertical;
        }
        .cadastrar {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .cadastrar:hover {
            background-color: #218838;
        }
        .add-link {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 20px;
        }
        .add-link:hover {
            background-color: #0056b3;
        }
        .remove-link {
            width: auto;
            color: white;
            background-color: #dc3545;
            border: none;
            padding: 4px 8px;
            font-size: 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .remove-link:hover {
            background-color: #c82333;
        }
        #linksContainer {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .link-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            gap: 10px;
        }
        .link-group input[type="text"],
        .link-group select {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .link-group select {
            flex: 0.6;
        }
    </style>
</head>
<body>

<%
    // Supondo que você já tenha obtido o curso com seus links associados
    User user = (User) request.getSession().getAttribute("user");
    int teacherId = user.getId();


    String courseIdParam = request.getParameter("courseId");
    int courseId = Integer.parseInt(courseIdParam);
    CourseDao courseDao = new CourseDao();
    Course course = null;
    try {
        course = courseDao.getCourseById(courseId);
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
%>

<div class="container">
    <h2>Editar Curso</h2>
    <form action="course" method="POST">
        <input type="hidden" name="courseId" value="<%= courseId %>">
        <input type="hidden" name="teacherId" value="<%= teacherId %>">
        <input type="hidden" name="_method" value="PUT">
        <div class="form-group">
            <label for="title">Título do Curso:</label>
            <input type="text" id="title" name="title" value="<%= course.getTitle() %>" required>
        </div>

        <div class="form-group">
            <label for="description">Descrição:</label>
            <textarea id="description" name="description" rows="4" required><%= course.getDescription() %></textarea>
        </div>

        <div class="form-group">
            <label for="hours">Quantidade de Horas:</label>
            <input type="number" id="hours" name="hours" value="<%= course.getHours() %>" required>
        </div>

        <div class="form-group" id="linksContainer">
            <label>Links/PDFs:</label>

            <%
                for (Link link : course.getLinks()) {
            %>
            <div class="link-group">
                <input type="hidden" name="linkId[]" value="<%= link.getId() %>">
                <label>
                    <input type="text" name="linkName[]" placeholder="Nome do Conteúdo" value="<%= link.getName() %>" required>
                </label>
                <label>
                    <select name="linkType[]" required>
                        <option value="" disabled>Identificação</option>
                        <option value="pdf" <%= link.getType().equals("pdf") ? "selected" : "" %>>PDF</option>
                        <option value="video" <%= link.getType().equals("video") ? "selected" : "" %>>Vídeo</option>
                        <option value="drive" <%= link.getType().equals("drive") ? "selected" : "" %>>Drive</option>
                        <option value="image" <%= link.getType().equals("image") ? "selected" : "" %>>Imagem</option>
                    </select>
                </label>
                <label>
                    <input type="text" name="linkUrl[]" placeholder="Link" value="<%= link.getUrl() %>" required>
                </label>
                <button type="button" class="remove-link" onclick="removeLink(this)">Remover</button>
            </div>
            <%
                }
            %>

        </div>

        <button type="button" class="add-link" onclick="addLink()">Adicionar Link/PDF</button>

        <div class="form-group">
            <button type="submit" class="cadastrar">Atualizar Curso</button>
        </div>
    </form>
</div>

<script>
    function addLink() {
        const container = document.getElementById('linksContainer');

        const newLinkGroup = document.createElement('div');
        newLinkGroup.classList.add('link-group');
        newLinkGroup.innerHTML = `
            <input type="text" name="linkName[]" placeholder="Nome do Conteúdo" required>
            <select name="linkType[]" required>
                <option value="" disabled selected>Identificação</option>
                <option value="pdf">PDF</option>
                <option value="video">Vídeo</option>
                <option value="drive">Drive</option>
                <option value="image">Imagem</option>
            </select>
            <input type="text" name="linkUrl[]" placeholder="Link" required>
            <button type="button" class="remove-link" onclick="removeLink(this)">Remover</button>
        `;

        container.appendChild(newLinkGroup);
    }

    function removeLink(element) {
        const linkGroup = element.parentNode;
        linkGroup.remove();
    }
</script>

</body>
</html>
