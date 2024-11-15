<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9;
        }
        .container {
            margin-top: 20px;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card {
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card-title {
            font-family: 'Arial', sans-serif;
            color: #007bff;
        }
        .user-info {
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        .label {
            font-weight: bold;
        }
        .btn-info {
            font-family: 'Arial', sans-serif;
            margin-right: 10px;
        }
        .navbar {
            background-color: #343a40;
        }
        .navbar-nav .nav-link {
            color: #ffffff !important;
            transition: color 0.3s ease;
        }
        .navbar-brand {
            font-weight: bold;
            color: #ffffff !important;
        }
        .navbar-nav .nav-link:hover {
            color: #007bff !important;
        }
        .navbar-dark .navbar-toggler {
            border-color: #ffffff;
        }
        .alert {
            display: none;
        }
        .user-info {
            font-weight: bold;
        }
        .user-info .label {
            font-weight: normal;
        }
        .form-group input, .form-group select {
            margin-bottom: 15px;
        }
        .btn-primary {
            margin-top: 10px;
        }
        .table th, .table td {
            text-align: center;
        }
        .table tr:hover {
            background-color: #f1f1f1;
        }
    </style>
    <script>
        function validateTransactionForm() {
            const amount = document.getElementById('amount').value;
            const upiPin = document.getElementById('upiPin').value;
            const errorMessage = document.getElementById('transactionError');
            if (amount <= 0) {
                errorMessage.textContent = 'Amount must be greater than 0.';
                errorMessage.style.display = 'block';
                return false;
            }
            if (upiPin.length !== 6 || isNaN(upiPin)) {
                errorMessage.textContent = 'UPI PIN must be 6 digits.';
                errorMessage.style.display = 'block';
                return false;
            }
            return true;
        }
    </script>
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
    <div class="container-fluid">
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
                
                String query = "SELECT u.full_name, u.mobile_number, a.account_number, a.balance, a.account_type " +
                               "FROM users u JOIN accounts a ON u.user_id = a.user_id WHERE u.user_id = ?";
                ps = conn.prepareStatement(query);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                
                if (rs.next()) {
        %>
        <div class="row mt-5">
            <!-- User Information -->
            <div class="col-md-1"></div>
            <div class="col-md-5 mx-auto">
                <div class="">
                    <div class="card-body ">
                        <h4 class="card-title text-primary">Welcome to SBI, <%= rs.getString("full_name") %></h4>
                        <p class="user-info"><span class="label font-weight-bold">Name:</span> <%= rs.getString("full_name") %></p>
                        <p class="user-info"><span class="label font-weight-bold">Phone Number:</span> <%= rs.getString("mobile_number") %></p>
                        <p class="user-info"><span class="label font-weight-bold">Account Number:</span> <%= rs.getString("account_number") %></p>
                        <p class="user-info"><span class="label font-weight-bold">Account Balance:</span> <%= rs.getBigDecimal("balance") %></p>
                        <p class="user-info"><span class="label font-weight-bold">Account Type:</span> <%= rs.getString("account_type") %></p>
                        <div class="mt-4">
                            <a href="transactionHistory.jsp" class="btn btn-info">View Transaction History</a>
                            <a href="digitalATMCard.jsp" class="btn btn-info">View Digital ATM Card</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Transactions Form -->
            <div class="col-md-6">
                <h4 class="text-center text-primary">Deposit/Withdraw/Transfer</h4>
                <div id="transactionError" class="alert alert-danger"></div>
                <form action="transactionAction.jsp" method="post" onsubmit="return validateTransactionForm()">
                    <div class="form-group">
                        <label for="transactionType">Transaction Type</label>
                        <select class="form-control" id="transactionType" name="transactionType" required>
                            <option value="Deposit">Deposit</option>
                            <option value="Withdrawal">Withdrawal</option>
                            <option value="Transfer">Transfer</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="amount">Amount</label>
                        <input type="number" class="form-control" id="amount" name="amount" required>
                    </div>
                    <div class="form-group">
                        <label for="accountNumber">Account Number (for Transfer)</label>
                        <input type="text" class="form-control" id="accountNumber" name="accountNumber">
                    </div>
                    <div class="form-group">
                        <label for="atmCardNumber">ATM Card Number (for Transfer)</label>
                        <input type="text" class="form-control" id="atmCardNumber" name="atmCardNumber">
                    </div>
                    <div class="form-group">
                        <label for="upiPin">UPI PIN</label>
                        <input type="password" class="form-control" id="upiPin" name="upiPin" required>
                    </div>
                    <button type="submit" class="btn btn-primary col-3 rounded-pill d-flex justify-content-center align-items-center mx-auto">Submit</button>
                </form>
            </div>
        </div>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("userHome.jsp?error=An error occurred during data retrieval");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
