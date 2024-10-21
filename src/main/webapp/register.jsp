<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cadastro - Course Wave</title>
  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #e9ecef;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      background-color: #fff;
      padding: 20px; /* Redução do padding */
      border-radius: 10px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      max-width: 360px; /* Redução da largura */
      width: 100%;
      animation: fadeIn 0.5s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    h2 {
      text-align: center;
      color: #333;
      font-size: 1.4rem;
      margin-bottom: 15px; /* Redução do espaço abaixo do título */
    }
    .form-group {
      margin-bottom: 12px; /* Redução do espaçamento entre os campos */
    }
    .form-group label {
      font-weight: 500;
      color: #495057;
      display: block;
      margin-bottom: 5px;
    }
    .form-group input {
      width: 100%;
      padding: 8px; /* Redução do padding */
      border: 1px solid #ced4da;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
      transition: border-color 0.3s;
    }
    .form-group input:focus {
      border-color: #80bdff;
      outline: none;
      box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
    }
    .form-group button {
      width: 100%;
      padding: 10px;
      background-color: #28a745;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      color: white;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .form-group button:hover {
      background-color: #218838;
    }
    .role-selector {
      display: flex;
      justify-content: space-around;
      margin-bottom: 15px;
      padding: 8px;
      background-color: #f8f9fa;
      border-radius: 6px;
      border: 1px solid #ced4da;
    }
    .role-selector label {
      display: flex;
      align-items: center;
      font-size: 14px;
      color: #495057;
      cursor: pointer;
    }
    .role-selector input {
      margin-right: 5px;
    }
    .role-selector label:hover {
      color: #007bff;
    }
    .error {
      color: red;
      text-align: center;
      font-size: 13px;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Cadastrar-se</h2>

  <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
  %>
  <div class="error">
    <%= error %>
  </div>
  <%
    }
  %>

  <form action="register" method="POST">
    <div class="form-group">
      <label for="name">Nome</label>
      <input type="text" id="name" name="name" required>
    </div>

    <div class="form-group">
      <label for="login">Login</label>
      <input type="text" id="login" name="login" required>
    </div>

    <div class="form-group">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" required>
    </div>

    <div class="form-group">
      <label for="password">Senha</label>
      <input type="password" id="password" name="password" required minlength="8">
    </div>

    <div class="form-group">
      <label for="confirm-password">Confirmar Senha</label>
      <input type="password" id="confirm-password" name="confirm-password" required minlength="8">
    </div>

    <div class="role-selector">
      <label><input type="radio" name="role" value="student" checked> Aluno</label>
      <label><input type="radio" name="role" value="teacher"> Professor</label>
    </div>

    <div class="form-group">
      <button type="submit">Cadastrar</button>
    </div>
  </form>
</div>

</body>
</html>
