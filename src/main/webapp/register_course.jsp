<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Course - Course Wave</title>
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
        .form-group input, .form-group textarea {
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
            background-color: #28a745; /* Green */
            color: white;
        }
        .form-group button:hover {
            background-color: #218838;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Register Course</h2>
    <form action="registerCourse" method="POST">
        <div class="form-group">
            <label for="courseTitle">Course Title:</label>
            <input type="text" id="courseTitle" name="courseTitle" required>
        </div>
        <div class="form-group">
            <label for="courseDescription">Course Description:</label>
            <textarea id="courseDescription" name="courseDescription" rows="4" required></textarea>
        </div>
        <div class="form-group">
            <label for="courseDuration">Course Duration:</label>
            <input type="text" id="courseDuration" name="courseDuration" required>
        </div>
        <div class="form-group">
            <button type="submit">Register Course</button>
        </div>
        <div class="error">
            <%
                String errorMessage = request.getParameter("errorMessage");
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
