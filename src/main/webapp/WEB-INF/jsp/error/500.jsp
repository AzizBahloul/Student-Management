<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Internal Server Error</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .error-container {
            margin-top: 10%;
        }
        .error-code {
            font-size: 10rem;
            font-weight: bold;
        }
        .error-message {
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
<div class="container text-center error-container">
    <h1 class="error-code text-danger">500</h1>
    <h2 class="error-message">Internal Server Error</h2>
    <p class="lead">Sorry, something went wrong on our end. Please try again later or contact support if the problem persists.</p>
    <a href="students" class="btn btn-primary">Go to Homepage</a>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>