<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%-- <%@ page import="com.google.gson.Gson" %> --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if admin is logged in
    session = request.getSession(false);
    if (session == null || session.getAttribute("admin_phonenumber") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .dashboard-container {
            margin-top: px;
<%--             box-shadow: 0 0 15px rgba(0, 0, 0, 0.1); --%>
            padding: 20px;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
        .dashboard-table {
            margin-top: 10px;
        }

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
<div class="container-fluid dashboard-container">
    <div class="row">
        <div class="col-md-4">
    <h5 class="text-center">Welcome to State Bank Of India</h5>
    <h5 class="text-center">Hello, <span class="text-primary"><%= session.getAttribute("full_name")%></span></h5>
     <h5 class="text-center">Phone : <span class="text-primary"> <%= session.getAttribute("admin_phonenumber")%></span></h5>
     </div>
     <div class="col-md-8">

    <table class="table table-bordered table-striped dashboard-table rounded-pill">
        <thead class="thead-dark">
        <tr>
            <th>Action</th>
            <th>Details</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>View All Users</td>
            <td><a href="view_users.jsp" class="btn btn-info col-4  rounded-pill">View Users</a></td>
        </tr>
        <tr>
            <td>View All Transactions</td>
            <td><a href="view_transactions.jsp" class="btn btn-info col-4  rounded-pill">View Transactions</a></td>
        </tr>
        <tr>
            <td>View User Queries</td>
            <td><a href="view_queries.jsp" class="btn btn-info col-4   rounded-pill">View Queries</a></td>
        </tr>
       <%--  <tr>
            <td>View User Queries</td>
            <td><a href="top_transactions.jsp" class="btn btn-info  rounded-pill">Top 10 Transactions</a></td>
        </tr> --%>
      <%--   <tr>
            <td>Logout</td>
            <td><a href="admin_logout.jsp" class="btn btn-danger  rounded-pill">Logout</a></td>
        </tr> --%>
        <tr>
            <td>Search User Details</td>
            <td>
                <form action="account_holder_detailes.jsp" method="get">
                    <div class="form-group">
                        <label for="accountNumber">Account Number:</label>
                        <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
                    </div>
                    <button type="submit" class="btn btn-primary col-4  rounded-pill">View Details</button>
                </form>
            </td>
        </tr>
         <tr>
            <td>Logout</td>
            <td><a href="admin_logout.jsp" class="btn btn-danger col-4  rounded-pill">Logout</a></td>
        </tr>
        </tbody>
    </table>
    </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
