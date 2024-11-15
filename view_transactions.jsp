<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Transactions</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .container {
            margin-top: 30px;
            padding: 20px;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
        .btn-back {
            margin-top: 20px;
            display: block;
            width: 200px;
            margin-left: auto;
            margin-right: auto;
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
<div class="container-fluid">
    <h2 class="text-center mt-3">All Transactions</h2>
    <a href="admin_dashboard.jsp" class="btn btn-dark btn-back rounded-pill">Admin Dashboard</a>
    <table class="table table-striped table-bordered table-hover mt-3">
        <thead class="thead-dark" style="position: sticky; top:0">
        <tr>
            <th>Transaction ID</th>
            <th>Full Name</th>
            <th>Account Number</th>
            <th>Type</th>
            <th>Amount</th>
            <th>Timestamp</th>
            <th>Description</th>
        </tr>
        </thead>
        <tbody>
        <%
            String url = "jdbc:mysql://localhost:3306/banksdb";
            String dbUser = "root";
            String dbPassword = "root";
           String query = "SELECT t.transaction_id, u.full_name, a.account_number, t.transaction_type, t.amount, t.transaction_date, t.description " +
               "FROM transactions t " +
               "JOIN accounts a ON t.account_number = a.account_number " +
               "JOIN users u ON a.user_id = u.user_id";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPassword);
                
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                
                while (rs.next()) {
                    int transactionId = rs.getInt("transaction_id");
                    String fullName = rs.getString("full_name");
                    String accountNumber = rs.getString("account_number");
                    String type = rs.getString("transaction_type");
                    double amount = rs.getDouble("amount");
                    Timestamp timestamp = rs.getTimestamp("transaction_date");
                    String description = rs.getString("description");
        %>
        <tr>
            <td><%= transactionId %></td>
            <td><%= fullName %></td>
            <td><%= accountNumber %></td>
            <td><%= type %></td>
            <td><%= amount %></td>
            <td><%= timestamp %></td>
            <td><%= description %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>
        </tbody>
    </table>
    <a href="admin_dashboard.jsp" class="btn btn-dark btn-back rounded-pill">Admin Dashboard</a>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
