<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9; /* Light grey background */
        }
        .container {
            margin-top: 20px;
            background: #ffffff; /* White background for the container */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        .navbar {
            background-color: #343a40; /* Dark navbar background */
        }
        .navbar-nav .nav-link {
            color: #ffffff !important; /* White text color */
        }
        .navbar-nav .nav-link:hover {
            color: #007bff !important; /* Blue color on hover */
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
                    <a class="nav-link" href="userHome.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="transactionHistory.jsp">Transaction_History</a>
                </li>
                  <li class="nav-item">
                    <a class="nav-link" href="digitalATMCard.jsp">Digital_ATM</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="userLogout.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fuild p-2">
        <h2 class="text-center">Transaction History</h2>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banksdb", "root", "root");
                
                String query = "SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date, t.description,transaction_status,transaction_fee " +
                               "FROM transactions t JOIN accounts a ON t.account_number = a.account_number " +
                               "WHERE a.user_id = ? ORDER BY t.transaction_date DESC";
                ps = conn.prepareStatement(query);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
        %>
        <table class="table table-striped ">
            <thead class="bg-dark text-white" style="position:sticky; top: 0;">
                <tr>
                    <th>Transaction ID</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Date/Time</th>
                    <th>Description</th>
                      <th>Status</th>
                        <th>Fee</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("transaction_id") %></td>
                    <td><%= rs.getString("transaction_type") %></td>
                    <td><%= rs.getBigDecimal("amount") %></td>
                    <td><%= rs.getTimestamp("transaction_date") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getString("transaction_status") %></td>
                     <td><%= rs.getString("transaction_fee") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
