<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Course Wave</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 50px;
            margin: 0;
        }
        .container {
            max-width: 400px;
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
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group button, .form-group a {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-align: center;
            color: white;
            text-decoration: none;
            margin-top: 10px;
        }
        .form-group button {
            background-color: #28a745; /* Verde */
        }
        .form-group button:hover {
            background-color: #218838;
        }
        .register-btn {
            background-color: #007bff; /* Azul */
        }
        .register-btn:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Login</h2>
    <form action="login" method="POST">
        <div class="form-group">
            <label for="login">Nome de Usuário:</label>
            <input type="text" id="login" name="login" required>
        </div>
        <div class="form-group">
            <label for="password">Senha:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <button type="submit">Entrar</button>
        </div>
        <div class="form-group">
            <a href="register.jsp" class="register-btn">Cadastrar-se</a>
        </div>
        <div class="error">
            <%
                // Acessando a mensagem de erro setada no LoginController
                String errorMessage = (String) request.getAttribute("error");
                if (errorMessage != null) {
            %>
            <p><%= errorMessage %></p>
            <%
                }
            %>
        </div>
    </form>
</div>

</body>
</html>
