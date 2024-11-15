<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital ATM Card</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9; /* Light grey background */
        }
        .container {
            margin-top: 20px;
            background: #ffffff; /* White background for the container */
            padding: 10px;
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
        .card-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 300px;

        }
        .card {
            width: 400px;
            height: 250px;
            background: linear-gradient(135deg, #007bff, #00c6ff); /* Gradient background */
            color: white;
            border-radius: 10px;
            padding: 20px;
            position: relative;
            font-family: 'Arial', sans-serif;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Card shadow */
        }
        .card-number {
            font-size: 1.5em;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }
        .card-info {
            margin: 10px 0;
        }
        .card-title {
            font-size: 1.2em;
            font-weight: bold;
        }
        .card-footer {
            position: absolute;
            bottom: 10px;
            left: 20px;
            font-size: 0.8em;
        }
        .bank-name {
            font-weight: bold;
            font-size: 1.2em;
        }
        .expiry-cvv {
            display: flex;
            justify-content: space-between;
        }
        .expiry-date, .cvv {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
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
    <div class="container col-md-4">
        <h2 class="text-center text-primary" style="font-style:solid">Digital ATM Card</h2>
        <div class="card-container">
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

                    String query = "SELECT u.full_name,a.atm_card_number, a.atm_card_expiry, a.atm_card_cvv " +
                                   "FROM accounts a JOIN users u ON a.user_id = u.user_id " +
                                   "WHERE u.user_id = ?";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, userId);
                    rs = ps.executeQuery();

                    if (rs.next()) {
            %>
            <div class="card">
                <div class="card-body">
                    <div class="bank-name">StateBankOfIndia</div>
                    <div class="user-full_name " style="font-style: bold;"><%= rs.getString("full_name") %></div>
                    <div class="card-number"><%= rs.getString("atm_card_number") %></div>

                    <div class="expiry-cvv">
                        <div class="expiry-date">Expiry: <%= rs.getString("atm_card_expiry") %></div>
                        <div class="cvv">CVV: <%= rs.getString("atm_card_cvv") %></div>
                    </div>
                </div>
                <div class="card-footer mx-3">
                    <small>Authorized User</small>
                </div>
            </div>
            <%
                    } else {
                        out.println("Card details not found.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
