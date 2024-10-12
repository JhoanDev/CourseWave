<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Curso - Course Wave</title>
    <style>
        /* Estilo global */
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

        /* Botão de cadastrar curso */
        .cadastrar {
            width: 100%;
            padding: 12px;
            background-color: #28a745; /* Verde */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .cadastrar:hover {
            background-color: #218838;
        }

        /* Botão de adicionar link */
        .add-link {
            width: 100%;
            padding: 12px;
            background-color: #007bff; /* Azul */
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

        /* Botão remover */
        .remove-link {
            width: auto;
            color: white;
            background-color: #dc3545; /* Vermelho */
            border: none;
            padding: 4px 8px;
            font-size: 12px;
            border-radius: 4px;
            cursor: pointer;
        }
        .remove-link:hover {
            background-color: #c82333;
        }

        /* Estilo do container de links */
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
    // Recuperando o ID do professor passado na URL
    String professorIdParam = request.getParameter("professorId");
    int professorId = -1;
    if (professorIdParam != null) {
        try {
            professorId = Integer.parseInt(professorIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
%>

<div class="container">
    <h2>Cadastrar Curso</h2>
    <form action="cadastrarCurso" method="POST">
        <div class="form-group" style="display:none;">
            <input type="hidden" name="teacherId" value="<%= professorId %>">
        </div>
        <div class="form-group">
            <label for="title">Título do Curso:</label>
            <input type="text" id="title" name="title" required aria-required="true">
        </div>

        <div class="form-group">
            <label for="description">Descrição:</label>
            <textarea id="description" name="description" rows="4" required aria-required="true" style="resize: vertical;"></textarea>
        </div>

        <div class="form-group">
            <label for="hours">Quantidade de Horas:</label>
            <input type="number" id="hours" name="hours" required aria-required="true">
        </div>

        <div class="form-group" id="linksContainer">
            <label>Links/PDFs:</label>
            <div class="link-group">
                <input type="text" name="linkName[]" placeholder="Nome do Conteúdo" required aria-required="true">
                <select name="linkType[]" required aria-required="true">
                    <option value="" disabled selected>Identificação</option>
                    <option value="pdf">PDF</option>
                    <option value="video">Vídeo</option>
                    <option value="drive">Drive</option>
                    <option value="image">Imagem</option>
                </select>
                <input type="text" name="linkUrl[]" placeholder="Link" required aria-required="true">
                <button type="button" class="remove-link" onclick="removeLink(this)">Remover</button>
            </div>
        </div>

        <button type="button" class="add-link" onclick="addLink()">Adicionar Link/PDF</button>

        <div class="form-group">
            <button type="submit" class="cadastrar">Cadastrar Curso</button>
        </div>
    </form>
</div>

<script>
    function addLink() {
        const container = document.getElementById('linksContainer');

        // Criar um novo grupo de inputs para o novo link
        const newLinkGroup = document.createElement('div');
        newLinkGroup.classList.add('link-group');
        newLinkGroup.innerHTML = `
            <input type="text" name="linkName[]" placeholder="Nome do Conteúdo" required aria-required="true">
            <select name="linkType[]" required aria-required="true">
                <option value="" disabled selected>Identificação</option>
                <option value="pdf">PDF</option>
                <option value="video">Vídeo</option>
                <option value="drive">Drive</option>
                <option value="image">Imagem</option>
            </select>
            <input type="text" name="linkUrl[]" placeholder="Link" required aria-required="true">
            <button type="button" class="remove-link" onclick="removeLink(this)">Remover</button>
        `;

        container.appendChild(newLinkGroup); // Adicionar o novo grupo de inputs ao container
    }

    function removeLink(element) {
        const linkGroup = element.parentNode;
        linkGroup.remove(); // Remover o grupo de inputs
    }
</script>

</body>
</html>
