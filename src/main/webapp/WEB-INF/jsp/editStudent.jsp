<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.management.model.Student" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student</title>
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
            <h2 class="text-center mb-4">Edit Student</h2>
            <%
                Student student = (Student) request.getAttribute("student");
                if (student != null) {
            %>
            <form action="students" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="<%= student.getId() %>">
                
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input 
                        type="text" 
                        id="name" 
                        name="name" 
                        class="form-control" 
                        value="<%= student.getName() %>" 
                        required>
                </div>
                
                <div class="mb-3">
                    <label for="age" class="form-label">Age</label>
                    <input 
                        type="number" 
                        id="age" 
                        name="age" 
                        class="form-control" 
                        value="<%= student.getAge() %>" 
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
                        value="<%= student.getGrade() %>" 
                        pattern="[A-Fa-f]" 
                        required>
                    <div class="form-text">Enter a grade between A and F.</div>
                </div>

                <div class="btn-container">
                    <button type="submit" class="btn btn-primary flex-grow-1">Update Student</button>
                    <a href="students" class="btn btn-secondary flex-grow-1">Cancel</a>
                </div>

                <div class="error-message text-center mt-3">
                    <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
                </div>
            </form>
            <% } else { %>
                <div class="alert alert-danger">Student not found.</div>
                <a href="students" class="btn btn-primary">Return to List</a>
            <% } %>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function validateForm() {
            const name = document.getElementById('name').value.trim();
            const age = document.getElementById('age').value;
            const grade = document.getElementById('grade').value.toUpperCase();

            if (name === '') {
                alert('Please enter a valid name');
                return false;
            }

            if (age < 5 || age > 100) {
                alert('Age must be between 5 and 100');
                return false;
            }

            if (!/^[A-F]$/.test(grade)) {
                alert('Grade must be between A and F');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
