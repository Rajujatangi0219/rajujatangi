<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.math.BigDecimal" %>
<%
    String transactionType = request.getParameter("transactionType");
    BigDecimal amount = new BigDecimal(request.getParameter("amount"));
    String accountNumber = request.getParameter("accountNumber");
    String atmCardNumber = request.getParameter("atmCardNumber");
    String upiPin = request.getParameter("upiPin");

    Connection conn = null;
    PreparedStatement ps = null;
    session = request.getSession();
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = "";
    boolean transactionSuccessful = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banksdb", "root", "root");

        // Fetch user details
        String query = "SELECT * FROM accounts WHERE user_id = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            String userAccountNumber = rs.getString("account_number");
            BigDecimal balance = rs.getBigDecimal("balance");

            if (transactionType.equals("Deposit")) {
                // Deposit
                String updateQuery = "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";
                ps = conn.prepareStatement(updateQuery);
                ps.setBigDecimal(1, amount);
                ps.setString(2, userAccountNumber);
                ps.executeUpdate();

                // Record transaction
                String insertQuery = "INSERT INTO transactions (account_number, transaction_type, amount, description) VALUES (?, ?, ?, ?)";
                ps = conn.prepareStatement(insertQuery);
                ps.setString(1, userAccountNumber);
                ps.setString(2, transactionType);
                ps.setBigDecimal(3, amount);
                ps.setString(4, "Deposit to account");
                ps.executeUpdate();

                message = "Deposit successful!";
                transactionSuccessful = true;

            } else if (transactionType.equals("Withdrawal")) {
                // Withdrawal
                if (balance.compareTo(amount) >= 0) {
                    String updateQuery = "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
                    ps = conn.prepareStatement(updateQuery);
                    ps.setBigDecimal(1, amount);
                    ps.setString(2, userAccountNumber);
                    ps.executeUpdate();

                    // Record transaction
                    String insertQuery = "INSERT INTO transactions (account_number, transaction_type, amount, description) VALUES (?, ?, ?, ?)";
                    ps = conn.prepareStatement(insertQuery);
                    ps.setString(1, userAccountNumber);
                    ps.setString(2, transactionType);
                    ps.setBigDecimal(3, amount);
                    ps.setString(4, "Withdrawal from account");
                    ps.executeUpdate();

                    message = "Withdrawal successful!";
                    transactionSuccessful = true;
                } else {
                    message = "Insufficient balance for withdrawal!";
                }

            } else if (transactionType.equals("Transfer")) {
                if (atmCardNumber != null && !atmCardNumber.isEmpty()) {
                    // Transfer using ATM Card Number
                    String atmQuery = "SELECT * FROM accounts WHERE atm_card_number = ?";
                    ps = conn.prepareStatement(atmQuery);
                    ps.setString(1, atmCardNumber);
                    ResultSet atmRs = ps.executeQuery();

                    if (atmRs.next()) {
                        String recipientAccountNumber = atmRs.getString("account_number");

                        // Check if sufficient balance
                        if (balance.compareTo(amount) >= 0) {
                            // Deduct from sender account
                            String updateSenderQuery = "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
                            ps = conn.prepareStatement(updateSenderQuery);
                            ps.setBigDecimal(1, amount);
                            ps.setString(2, userAccountNumber);
                            ps.executeUpdate();

                            // Add to recipient account
                            String updateRecipientQuery = "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";
                            ps = conn.prepareStatement(updateRecipientQuery);
                            ps.setBigDecimal(1, amount);
                            ps.setString(2, recipientAccountNumber);
                            ps.executeUpdate();

                            // Record transaction for sender
                            String insertSenderQuery = "INSERT INTO transactions (account_number, transaction_type, amount, description) VALUES (?, ?, ?, ?)";
                            ps = conn.prepareStatement(insertSenderQuery);
                            ps.setString(1, userAccountNumber);
                            ps.setString(2, transactionType);
                            ps.setBigDecimal(3, amount);
                            ps.setString(4, "Transfer to account using ATM card");
                            ps.executeUpdate();

                            // Record transaction for recipient
                            String insertRecipientQuery = "INSERT INTO transactions (account_number, transaction_type, amount, description) VALUES (?, ?, ?, ?)";
                            ps = conn.prepareStatement(insertRecipientQuery);
                            ps.setString(1, recipientAccountNumber);
                            ps.setString(2, "Deposit");
                            ps.setBigDecimal(3, amount);
                            ps.setString(4, "Transfer from account");
                            ps.executeUpdate();

                            message = "Transfer to ATM card successful!";
                            transactionSuccessful = true;
                        } else {
                            message = "Insufficient balance for transfer!";
                        }
                    } else {
                        message = "Invalid ATM Card Number!";
                    }

                } else if (accountNumber != null && !accountNumber.isEmpty()) {
                    // Transfer using Account Number
                    if (balance.compareTo(amount) >= 0) {
                        // Deduct from sender account
                        String updateSenderQuery = "UPDATE accounts SET balance = balance - ? WHERE account_number = ?";
                        ps = conn.prepareStatement(updateSenderQuery);
                        ps.setBigDecimal(1, amount);
                        ps.setString(2, userAccountNumber);
                        ps.executeUpdate();

                        // Add to recipient account
                        String updateRecipientQuery = "UPDATE accounts SET balance = balance + ? WHERE account_number = ?";
                        ps = conn.prepareStatement(updateRecipientQuery);
                        ps.setBigDecimal(1, amount);
                        ps.setString(2, accountNumber);
                        ps.executeUpdate();

                        // Record transaction for sender
                        String insertSenderQuery = "INSERT INTO transactions (account_number, transaction_type, amount, description) VALUES (?, ?, ?, ?)";
                        ps = conn.prepareStatement(insertSenderQuery);
                        ps.setString(1, userAccountNumber);
                        ps.setString(2, transactionType);
                        ps.setBigDecimal(3, amount);
                        ps.setString(4, "Transfer to account using Account Number");
                        ps.executeUpdate();

                        // Record transaction for recipient
                        String insertRecipientQuery = "INSERT INTO transactions (account_number, transaction_type, amount, description) VALUES (?, ?, ?, ?)";
                        ps = conn.prepareStatement(insertRecipientQuery);
                        ps.setString(1, accountNumber);
                        ps.setString(2, "Deposit");
                        ps.setBigDecimal(3, amount);
                        ps.setString(4, "Transfer from account");
                        ps.executeUpdate();

                        message = "Transfer to account successful!";
                        transactionSuccessful = true;
                    } else {
                        message = "Insufficient balance for transfer!";
                    }
                } else {
                    message = "Please provide account number or ATM card number!";
                }
            } else {
                message = "Invalid transaction type!";
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        message = "An error occurred during transaction!";
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!-- Transaction Result Page -->
<html>
<head>
    <title>Transaction Result</title>
    <style>
        .message-box {
            margin: 50px auto;
            padding: 20px;
            width: 50%;
            background-color: #f7f7f7;
            text-align: center;
            border: 1px solid #ddd;
        }
        .message-box h2 {
            color: green;
        }
        .back-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <h2><%= message %></h2>
        <% if (transactionSuccessful) { %>
            <a class="back-button" href="userHome.jsp">Back to User Home</a>
        <% } else { %>
            <a class="back-button" href="userHome.jsp">Try Again</a>
        <% } %>
    </div>
</body>
</html>
