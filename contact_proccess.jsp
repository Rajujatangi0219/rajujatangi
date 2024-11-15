<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Submission Result</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .message-container {
            margin-top: 50px;
        }
        .message-container .alert {
            font-size: 1.2em;
            padding: 20px;
        }
        .back-link {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container message-container">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <%
                // Database connection details
                String url = "jdbc:mysql://localhost:3306/banksdb"; // Update with your database name
                String username = "root"; // Update with your database username
                String password = "root"; // Update with your database password

                // Retrieve form data
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String subject = request.getParameter("subject");
                String message = request.getParameter("message");

                // Declare variables for connection and statement
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish connection to the database
                    conn = DriverManager.getConnection(url, username, password);

                    // SQL query to insert data into the contacts table
                    String sql = "INSERT INTO contacts (name, email, subject, message) VALUES (?, ?, ?, ?)";

                    // Prepare the statement
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, subject);
                    pstmt.setString(4, message);

                    // Execute the query
                    int rows = pstmt.executeUpdate();

                    if (rows > 0) {
                        out.println("<div class='alert alert-success text-center'>Thank you for contacting us! Your message has been received.</div>");
                    } else {
                        out.println("<div class='alert alert-danger text-center'>There was an error processing your request. Please try again later.</div>");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger text-center'>There was an error processing your request. Please try again later.</div>");
                } finally {
                    // Close resources
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            <div class="text-center back-link">
                <a href="index.html" class="btn btn-primary">Back to Home</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
