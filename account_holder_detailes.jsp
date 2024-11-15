<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User, Account, and Transaction Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-container {
            margin: 20px auto;
            width: 98%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .btn-back {
            display: block;
            margin: 20px auto;
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
    <a href="admin_dashboard.jsp" class="btn btn-dark btn-back col-2 rounded-pill">Admin Dashboard</a>
    <%
        String url = "jdbc:mysql://localhost:3306/banksdb";
        String dbUser = "root";
        String dbPassword = "root";
        String accountNumber = request.getParameter("accountNumber");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        if (accountNumber != null && !accountNumber.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // Fetch user details
               String userQuery = "SELECT u.*, a.account_number FROM users u JOIN accounts a ON u.user_id = a.user_id WHERE a.account_number = ?";

                pstmt = conn.prepareStatement(userQuery);
                pstmt.setString(1, accountNumber);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    %>
                    <div class="table-container">
                        <h2 class="text-center">User Details</h2>
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                            <tr>
                                <th>User ID</th>
                                <th>Full Name</th>
                                <th>Mobile Number</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Date of Birth</th>
                                <th>Age</th>
                                <th>Account Type</th>
                                <th>Status</th>
                                <th>Last Login</th>
                                <th>Created At</th>
                                <th>Updated At</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><%= rs.getInt("user_id") %></td>
                                <td><%= rs.getString("full_name") %></td>
                                <td><%= rs.getString("mobile_number") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= rs.getString("address") %></td>
                                <td><%= rs.getDate("dob") %></td>
                                <td><%= rs.getInt("age") %></td>
                                <td><%= rs.getString("account_type") %></td>
                                <td><%= rs.getString("status") %></td>
                                <td><%= rs.getTimestamp("last_login") %></td>
                                <td><%= rs.getTimestamp("created_at") %></td>
                                <td><%= rs.getTimestamp("updated_at") %></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <%
                } else {
                    out.println("<div class='alert alert-warning text-center'>No user found with the account number: " + accountNumber + "</div>");
                }

                // Fetch account details
                String accountQuery = "SELECT * FROM accounts WHERE account_number = ?";
                pstmt = conn.prepareStatement(accountQuery);
                pstmt.setString(1, accountNumber);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    %>
                    <div class="table-container">
                        <h2 class="text-center">Account Details</h2>
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                            <tr>
                                <th>Account ID</th>
                                <th>Account Number</th>
                                <th>ATM Card Number</th>
                                <th>Expiry Date</th>
                                <th>CVV</th>
                                <th>Balance</th>
                                <th>Account Type</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th>Updated At</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td><%= rs.getInt("account_id") %></td>
                                <td><%= rs.getString("account_number") %></td>
                                <td><%= rs.getString("atm_card_number") %></td>
                                <td><%= rs.getDate("atm_card_expiry") %></td>
                                <td><%= rs.getString("atm_card_cvv") %></td>
                                <td><%= rs.getDouble("balance") %></td>
                                <td><%= rs.getString("account_type") %></td>
                                <td><%= rs.getString("status") %></td>
                                <td><%= rs.getTimestamp("created_at") %></td>
                                <td><%= rs.getTimestamp("updated_at") %></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <%
                } else {
                    out.println("<div class='alert alert-warning text-center'>No account details found for account number: " + accountNumber + "</div>");
                }

                // Fetch transaction details
                String transactionQuery = "SELECT * FROM transactions WHERE account_number = ?";
                pstmt = conn.prepareStatement(transactionQuery);
                pstmt.setString(1, accountNumber);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    %>
                    <div class="table-container">
                        <h2 class="text-center">Transaction History</h2>
                        <table class="table table-bordered table-striped">
                            <thead class="thead-dark">
                            <tr>
                                <th>Transaction ID</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Transaction Date</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Reference Number</th>
                                <th>Transaction Fee</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                            do {
                                %>
                                <tr>
                                    <td><%= rs.getInt("transaction_id") %></td>
                                    <td><%= rs.getString("transaction_type") %></td>
                                    <td><%= rs.getDouble("amount") %></td>
                                    <td><%= rs.getTimestamp("transaction_date") %></td>
                                    <td><%= rs.getString("description") %></td>
                                    <td><%= rs.getString("transaction_status") %></td>
                                    <td><%= rs.getString("reference_number") %></td>
                                    <td><%= rs.getDouble("transaction_fee") %></td>
                                </tr>
                                <%
                            } while (rs.next());
                            %>
                            </tbody>
                        </table>
                    </div>
                    <%
                } else {
                    out.println("<div class='alert alert-warning text-center'>No transaction history found for account number: " + accountNumber + "</div>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger text-center'>An error occurred: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<div class='alert alert-danger text-center'>Invalid account number. Please try again.</div>");
        }
    %>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
