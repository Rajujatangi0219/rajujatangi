<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Queries</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .table-container {
            margin: 20px auto;
            max-width: 100%;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table .thead-dark th {
            background-color: #343a40;
            color: white;
        }
         <%-- .container a{
             display: flex;
            justify-content: center;
            align-items: center;
           
            position: relative;
            left: 50%;
         } --%> 
         
        /* Navbar styling */
        .navbar {
            margin-bottom: 20px;
            transition: background-color 0.3s ease;
            background-color: #343a40; /* Dark navbar background */
            position: sticky;
            top: 0;
            z-index: 1020; /* Ensures navbar is on top of other elements */
        }

        .navbar-nav .nav-link {
            color: #ffffff !important; /* White text color */
            transition: color 0.3s ease;
        }

        .navbar-brand {
            font-weight: bold;
            color: #ffffff !important; /* White text color for brand */
        }

        .navbar-toggler-icon {
            background-image: url('data:image/svg+xml;charset=utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path stroke="currentColor" stroke-width="2" d="M5 7h20M5 15h20M5 23h20"/></svg>');
        }

        .navbar-nav .nav-link:hover {
            color: #007bff !important; /* Blue color on hover */
        }

        .navbar-dark .navbar-nav .nav-link.active {
            color: #007bff !important; /* Blue color for active link */
        }

        .navbar-dark .navbar-toggler {
            border-color: #ffffff; /* White border for toggler */
        }
    </style>
</head>
<body>
     <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">StateBankOfIndia</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="admin_dashboard.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="view_users.jsp">Users</a>
                </li>
                 <!-- New Navbar Items -->
                <li class="nav-item">
                    <a class="nav-link" href="view_transactions.jsp">Transactions</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="view_queries.jsp">Queries</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="admin_logout.jsp">Logout</a>
                </li>
              
               
            </ul>
        </div>
    </nav>

<div class="container-fuild table-container">
    <h2 class="text-center mb-3">User Queries</h2>
     <a href="admin_dashboard.jsp" class="btn btn-dark btn-back text-center mx-auto d-flex justify-content-center col-2 rounded-pill">Admin Dashboard</a>
    <table class="table table-striped table-bordered mt-2">
        <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Subject</th>
                <th>Message</th>
                <th>Created At</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Database connection parameters
                String url = "jdbc:mysql://localhost:3306/banksdb";
                String user = "root";
                String password = "root";

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    // Establish the connection
                    conn = DriverManager.getConnection(url, user, password);
                    // Create a statement object to execute the query
                    stmt = conn.createStatement();
                    // Execute the query to fetch user queries
                    String query = "SELECT * FROM contacts";
                    rs = stmt.executeQuery(query);

                    // Iterate through the result set and display data
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String subject = rs.getString("subject");
                        String message = rs.getString("message");
                        Timestamp createdAt = rs.getTimestamp("created_at");

                        // Display each record in a table row
                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= email %></td>
                            <td><%= subject %></td>
                            <td><%= message %></td>
                            <td><%= createdAt %></td>
                        </tr>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close the database resources
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
   
</div>
 <a href="admin_dashboard.jsp" class="btn btn-dark btn-back mx-auto d-flex justify-content-center col-2 rounded-pill">Admin Dashboard</a>

<!-- Bootstrap and jQuery scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
