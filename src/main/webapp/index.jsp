<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Page</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-btn {
            position: fixed;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body class="bg-light">
<div class="container text-center mt-5">
    <h1 class="display-4">Welcome to the Student Management System</h1>
    <p class="lead">Please click the button to log in</p>

    <!-- Login button -->
    <a href="login" class="btn btn-primary login-btn">Login</a>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
