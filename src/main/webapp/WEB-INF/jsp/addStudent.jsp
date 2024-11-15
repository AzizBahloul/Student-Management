<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .btn-container {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Student Management</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link btn btn-danger text-white" href="logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container mt-5">
    <div class="form-container">
        <h2 class="text-center mb-4">Add Student</h2>
        <form id="addStudentForm" action="students" method="post">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input 
                    type="text" 
                    id="name" 
                    name="name" 
                    class="form-control" 
                    placeholder="e.g., John Doe" 
                    required>
            </div>
            <div class="mb-3">
                <label for="age" class="form-label">Age</label>
                <input 
                    type="number" 
                    id="age" 
                    name="age" 
                    class="form-control" 
                    placeholder="e.g., 18" 
                    min="5" 
                    max="100" 
                    required>
            </div>
            <div class="mb-3">
                <label for="grade" class="form-label">Grade</label>
                <input 
                    type="text" 
                    id="grade" 
                    name="grade" 
                    class="form-control" 
                    placeholder="e.g., A" 
                    required 
                    pattern="[A-Fa-f]">
                <div class="form-text">Enter a grade between A and F.</div>
            </div>
            <div class="btn-container">
                <button type="submit" name="submitAction" value="addAndReturn" class="btn btn-primary flex-grow-1">
                    Add & Return to List
                </button>
                <button type="submit" name="submitAction" value="addAndStay" class="btn btn-success flex-grow-1">
                    Add Another Student
                </button>
            </div>
            <div class="error-message text-center mt-3">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
            </div>
        </form>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
