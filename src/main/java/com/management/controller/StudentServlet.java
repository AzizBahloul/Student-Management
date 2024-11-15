package com.management.controller;

import com.management.model.Student;
import com.management.utils.DatabaseUtil;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.FindIterable;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(StudentServlet.class);
    private MongoCollection<Document> studentCollection;

    @Override
    public void init() throws ServletException {
        MongoDatabase database = DatabaseUtil.getDatabase();
        studentCollection = database.getCollection("students");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("showAddForm".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/jsp/addStudent.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else {
            // Always fetch fresh list when displaying students
            listStudents(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addStudent(request, response);
        } else if ("edit".equals(action)) {
            updateStudent(request, response);
        } else if ("delete".equals(action)) {
            deleteStudent(request, response);
        } else {
            listStudents(request, response);  // Default action: List students
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> studentList = new ArrayList<>();
        try {
            FindIterable<Document> documents = studentCollection.find();
            for (Document doc : documents) {
                Student student = new Student(
                    doc.getObjectId("_id"),  // Now matches the constructor
                    doc.getString("name"),
                    doc.getInteger("age"),
                    doc.getString("grade")
                );
                studentList.add(student);
                logger.info("Found student: {}", student);
            }
        } catch (Exception e) {
            logger.error("Error fetching students: {}", e.getMessage());
            setErrorMessageAndForward(request, response, "Error fetching students");
            return;
        }

        request.setAttribute("studentList", studentList);
        request.getRequestDispatcher("/WEB-INF/jsp/studentList.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        int age;
        String grade = request.getParameter("grade");
        String submitAction = request.getParameter("submitAction");

        try {
            age = Integer.parseInt(request.getParameter("age"));
        } catch (NumberFormatException e) {
            logger.error("Invalid age input: {}", request.getParameter("age"), e);
            setErrorMessageAndForward(request, response, "Invalid age format.");
            return;
        }

        Document student = new Document()
                .append("name", name)
                .append("age", age)
                .append("grade", grade);

        try {
            studentCollection.insertOne(student);
            logger.info("Added new student: {}", student.toJson());
            
            // Determine redirect based on button clicked
            if ("addAndReturn".equals(submitAction)) {
                response.sendRedirect("students");
            } else if ("addAndStay".equals(submitAction)) {
                request.setAttribute("successMessage", "Student added successfully!");
                request.getRequestDispatcher("/WEB-INF/jsp/addStudent.jsp").forward(request, response);
            }
        } catch (Exception e) {
            logger.error("Error adding student: {}", student.toJson(), e);
            setErrorMessageAndForward(request, response, "Error adding student.");
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String grade = request.getParameter("grade");
        int age;

        try {
            age = Integer.parseInt(request.getParameter("age"));
        } catch (NumberFormatException e) {
            logger.error("Invalid age format: {}", request.getParameter("age"));
            setErrorMessageAndForward(request, response, "Invalid age format");
            return;
        }

        try {
            ObjectId id = new ObjectId(idStr);
            Document filter = new Document("_id", id);
            Document update = new Document("$set", new Document()
                    .append("name", name)
                    .append("age", age)
                    .append("grade", grade.toUpperCase()));

            studentCollection.updateOne(filter, update);
            logger.info("Updated student with ID: {}", idStr);
            response.sendRedirect("students");
        } catch (Exception e) {
            logger.error("Error updating student: {}", e.getMessage());
            setErrorMessageAndForward(request, response, "Error updating student");
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String idStr = request.getParameter("id");
        
        try {
            ObjectId id = new ObjectId(idStr);
            Document filter = new Document("_id", id);

            // Execute deletion
            var result = studentCollection.deleteOne(filter);
            
            if (result.getDeletedCount() > 0) {
                logger.info("Successfully deleted student with ID: {}", idStr);
            } else {
                logger.warn("No student found with ID: {}", idStr);
            }
            
            response.sendRedirect("students");
        } catch (IllegalArgumentException e) {
            logger.error("Invalid ObjectId format: {}", idStr, e);
            setErrorMessageAndForward(request, response, "Invalid student ID format");
        } catch (Exception e) {
            logger.error("Error deleting student with ID: {}", idStr, e);
            setErrorMessageAndForward(request, response, "Error deleting student");
        }
    }

    private boolean isUserLoggedIn(HttpServletRequest request) {
        return request.getSession(false) != null && request.getSession().getAttribute("user") != null;
    }

    private void setErrorMessageAndForward(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);  // Assuming you have an error.jsp for displaying error messages
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        try {
            ObjectId id = new ObjectId(idStr);
            Document studentDoc = studentCollection.find(new Document("_id", id)).first();
            
            if (studentDoc != null) {
                Student student = new Student(
                    studentDoc.getObjectId("_id"),
                    studentDoc.getString("name"),
                    studentDoc.getInteger("age"),
                    studentDoc.getString("grade")
                );
                request.setAttribute("student", student);
                request.getRequestDispatcher("/WEB-INF/jsp/editStudent.jsp").forward(request, response);
            } else {
                logger.error("Student with ID {} not found", idStr);
                response.sendRedirect("students");
            }
        } catch (Exception e) {
            logger.error("Error showing edit form: {}", e.getMessage());
            response.sendRedirect("students");
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        
         if (DatabaseUtil.getMongoClient() != null) { 
             ((com.mongodb.client.MongoClient) DatabaseUtil.getMongoClient()).close(); 
             logger.info("MongoDB connection closed."); 
         }
     }
}