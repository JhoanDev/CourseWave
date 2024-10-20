<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cadastro - Course Wave</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      padding: 50px;
      margin: 0;
    }
    .container {
      max-width: 500px;
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
    .form-group button {
      width: 100%;
      padding: 10px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      text-align: center;
      color: white;
      background-color: #28a745; /* Verde */
    }
    .form-group button:hover {
      background-color: #218838;
    }
    .role-selector {
      margin-bottom: 20px;
      text-align: center;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Cadastrar-se</h2>

  <!-- Alerta de erro -->
  <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
  %>
  <div style="color: red; margin-bottom: 15px;">
    <%= error %>
  </div>
  <%
    }
  %>

  <form action="register" method="POST">
    <!-- Seu formulário existente -->
    <div class="form-group">
      <label for="name">Nome:</label>
      <input type="text" id="name" name="name" required>
    </div>

    <div class="form-group">
      <label for="login">Login:</label>
      <input type="text" id="login" name="login" required>
    </div>

    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" required>
    </div>

    <div class="form-group">
      <label for="password">Senha:</label>
      <input type="password" id="password" name="password" required minlength="8">
    </div>

    <div class="form-group">
      <label for="confirm-password">Confirmar Senha:</label>
      <input type="password" id="confirm-password" name="confirm-password" required minlength="8">
    </div>

    <div class="role-selector">
      <label>
        <input type="radio" name="role" value="student" checked> Aluno
      </label>
      <label>
        <input type="radio" name="role" value="teacher"> Professor
      </label>
    </div>

    <div class="form-group">
      <button type="submit">Cadastrar</button>
    </div>
  </form>
</div>

</body>
</html>