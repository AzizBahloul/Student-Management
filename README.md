 

**Student Directory Management Application**

This project is a Student Directory Management Application built using Java with Jakarta EE technologies. The purpose of this application is to provide a platform for managing student records, enabling users to perform CRUD operations, view student information, and manage user sessions. It leverages servlets and JSP (Java Server Pages) for server-side rendering, along with Bootstrap for front-end styling.

### Key Features:
- **Student Management**: Provides functionality to add, edit, delete, and view student details.
- **Login System**: Implements a simple login system for users to authenticate and manage student records.
- **Error Handling**: Custom error pages for common HTTP errors (404, 500).
- **Session Management**: Supports user sessions with a 30-minute timeout to ensure security and a smooth user experience.
- **Responsive UI**: Built with Bootstrap 4 for a mobile-friendly, responsive interface.

### Technologies Used:
- **Java 17**: The application is built using Java 17, taking advantage of its latest features and stability.
- **Jakarta EE**: The application uses Jakarta EE libraries including Jakarta Servlet, JSP, and EL (Expression Language) to build the server-side functionality.
- **Maven**: The project is managed using Maven for dependency management, building, and packaging.
- **Bootstrap**: For front-end styling, Bootstrap is used to create a responsive and modern user interface.
- **SLF4J**: A logging framework is included to help with debugging and monitoring.

### Project Structure:
- **src/main/java**: Contains Java source code including servlets and utility classes.
- **src/main/webapp**: Contains JSP files, including pages for managing students and handling errors, along with static resources like CSS and JS.
- **WEB-INF**: Contains configuration files for the web application, including the `web.xml` file for servlet mappings, welcome pages, and error pages.
- **pom.xml**: The Maven project configuration file, which includes dependencies for Jakarta EE, Bootstrap, SLF4J, and other necessary libraries.
- **error pages**: Custom 404 and 500 error pages are configured to enhance user experience when encountering errors.

### Setup Instructions:
1. Clone this repository:
   ```
   git clone https://github.com/your-username/student-directory-management.git
   ```
2. Navigate to the project directory:
   ```
   cd student-directory-management
   ```
3. Build the project using Maven:
   ```
   mvn clean install
   ```
4. Deploy the WAR file to a Jakarta EE compatible server like Tomcat 10.x or Jetty.
   - For Tomcat, place the WAR file in the `webapps` folder of your Tomcat installation.
   - Start the server and access the application at `http://localhost:8080/student/`.

### License:
This project is open-source and distributed under the MIT License. See the [LICENSE](LICENSE) file for more information.

---
 
