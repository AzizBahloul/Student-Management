<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.management.model.Student" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management - Student List</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* General Styles */
        body {
            background-color: #fafafa;
        }

        /* Navbar Styles */
        .navbar {
            background-color: #f8f9fa;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        .navbar-brand {
            font-weight: bold;
        }

        /* Button Styles */
        .btn-outline-primary {
            border-color: #007bff;
            color: #007bff;
        }
        .btn-outline-primary:hover {
            background-color: #007bff;
            color: #ffffff;
        }
        .btn-outline-danger {
            border-color: #dc3545;
            color: #dc3545;
        }
        .btn-outline-danger:hover {
            background-color: #dc3545;
            color: #ffffff;
        }

        /* Table Styles */
        .table thead {
            background-color: #343a40;
            color: #ffffff;
        }
        .btn-custom {
            min-width: 80px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light">
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

    <!-- Main Content -->
    <div class="container mt-5 mb-5">
        <h2 class="text-center mb-4">Student List</h2>
        
        <!-- Add Student Button -->
        <div class="mb-4 text-end">
            <a href="students?action=showAddForm" class="btn btn-success">
                <i class="bi bi-plus-circle me-2"></i>Add Student
            </a>
        </div>

        <!-- Student Table -->
        <table class="table table-hover table-bordered align-middle">
            <thead>
                <tr>
                    <th scope="col" class="text-center">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col" class="text-center">Age</th>
                    <th scope="col">Grade</th>
                    <th scope="col" class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Student> studentList = (List<Student>) request.getAttribute("studentList");
                    if (studentList != null && !studentList.isEmpty()) {
                        for (Student student : studentList) {
                %>
                <tr>
                    <td class="text-center"><%= student.getId() %></td>
                    <td><%= student.getName() %></td>
                    <td class="text-center"><%= student.getAge() %></td>
                    <td><%= student.getGrade() %></td>
                    <td class="text-center">
                        <a href="students?action=edit&id=<%= student.getId() %>" 
                           class="btn btn-outline-primary btn-sm btn-custom me-2">
                            Edit
                        </a>
                        <form action="students" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this student?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= student.getId() %>">
                            <button type="submit" class="btn btn-outline-danger btn-sm btn-custom">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" class="text-center">No students found.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
