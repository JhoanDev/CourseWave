<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    session.invalidate(); // Isso encerra a sessão atual.
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Course Wave</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e9ecef;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        h2 {
            text-align: center;
            color: #333;
            font-weight: 700;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #495057;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            border-color: #80bdff;
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
        }
        .btn-group button, .btn-group a {
            flex: 1;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
            color: white;
            text-decoration: none;
        }
        .btn-group button {
            background-color: #28a745;
            margin-right: 10px;
        }
        .btn-group button:hover {
            background-color: #218838;
        }
        .btn-group a {
            background-color: #007bff;
        }
        .btn-group a:hover {
            background-color: #0056b3;
        }
        .error {
            color: red;
            text-align: center;
            font-size: 14px;
            margin-top: 15px;
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
        <div class="btn-group">
            <button type="submit">Entrar</button>
            <a href="register.jsp" class="register-btn">Cadastrar-se</a>
        </div>
        <div class="error">
            <%
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
